class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, :dependent => :destroy
  # before_create :set_purchased
  before_save :update_subtotal

  def subtotal
    cart_items.collect{|i| i.valid? ? (i.quantity * i.unit_price) : 0}.sum
  end

  def purchased
    if persisted?
      self[:purchased]
    else
      false
    end
  end

  def tax
    if persisted?
      self[:tax]
    else
      0
    end
  end

  def self.view_cart(user_id)
    @user = User.find(user_id)
    @cart = Cart.find_by(user: @user, purchased: false)
    puts "name: #{@cart.user.name}, sub: #{@cart.subtotal}"
    @cart.cart_items.each do |item|
      row = "\tProduct: #{item.product.title}"
      row = row + "\t\t Price: #{item.unit_price}"
      row = row + "\t\t quantity: #{item.quantity}"
      puts "#{row}"
    end
  end


  def self.add_to_cart(user_id, product_id, quantity)
    @user = User.find(user_id)
    @product = Product.find(product_id)
    @cart = Cart.find_or_create_by(user: @user, purchased: false)
    @cart_item = CartItem.find_or_create_by(cart: @cart, product: @product)
    puts "old q: #{@cart_item.quantity}"

    @new_quantity = @cart_item.quantity + quantity.to_i
    if @new_quantity > @cart_item.product.available_inventory
      ApplicationHelper.exception("cannot add #{@cart_item.product.title}, quantity: #{@cart_item.quantity}")
      if @cart_item.quantity == 0
        @cart_item.destroy
      else
        puts "Item: #{@cart_item.product.title}, quantity: #{@cart_item.quantity}, unit: #{@cart_item.unit_price}, total: #{@cart_item.total_price}"
      end
    else
      @cart_item.update_attribute(:quantity, @new_quantity)
      puts "Added: #{@cart_item.product.title}, quantity: #{@cart_item.quantity}, unit: #{@cart_item.unit_price}, total: #{@cart_item.total_price}"
    end
  end


  def self.remove_from_cart(user_id, product_id, quantity)
    @user = User.find(user_id)
    @product = Product.find(product_id)
    @cart = Cart.find_by(user: @user, purchased: false)
    if @cart.nil?
      ApplicationHelper.exception("Cart is empty")
    else
      @cart_item = CartItem.find_by(cart: @cart, product: @product)
      if @cart_item.nil?
        ApplicationHelper.exception("Cart doesnt contain #{@product.title}")
      else
        @new_quantity = @cart_item.quantity - quantity.to_i
        if @new_quantity < 0
          ApplicationHelper.exception("Can't deduct more that available in cart")
        elsif @new_quantity == 0
          @cart_item.destroy
        else
          @cart_item.update_attribute(:quantity, @new_quantity)
        end
      end
    end
    # puts "old q: #{@cart_item.quantity}"
  end

  def self.purchase(user_id)
    @user = User.find(user_id)
    @cart = Cart.find_by(user: @user, purchased: false)
    if @cart.nil? || @cart.cart_items.size == 0
      ApplicationHelper.exception("Cart is empty")
    else
      @cart_items = CartItem.where(cart: @cart)
      @cart_items.each do |item|
        # update inventory
        # add to history
        @product = Product.find(item.product.id)
        @new_quantity = @product.available_inventory - item.quantity
        unless @new_quantity >= 0
          ApplicationHelper.exception("can't deduct inventory for #{@product.title}")
        end
        @product.update_attribute(:available_inventory, @new_quantity)
      end
      @final_cost = @cart.subtotal + @cart.subtotal*@cart.tax
      History.add_to_history(@user, @cart_items, @final_cost)
      @cart.update_attribute(:purchased, true)
    end
  end

  private
    def set_purchased
      self.purchased ||= false
      self.subtotal ||= 0
      self.tax ||= 0
    end

    def update_subtotal
      self[:subtotal] = subtotal
      self[:tax] = tax
      self[:purchased] = purchased
    end
end

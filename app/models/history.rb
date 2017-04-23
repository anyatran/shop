class History < ApplicationRecord
  belongs_to :user
  has_many :purchased_items, :dependent => :destroy

  validate :user_present
  # before_save :finalize

  def self.add_to_history(user, cart_items, final_cost)
    @history = History.create(user: user, final_cost: final_cost)

    cart_items.each do |item|
      @purchased_item = PurchasedItem.create(product: item.product, history: @history, quantity: item.quantity, total_cost: item.total_price)
    end
  end

  def self.view_history(user_id)
    @user = User.find(user_id)
    @histories = History.where(user: @user)
    puts "User: #{@user.name}"
    @histories.each do |history|
      puts "\tDate: #{history.created_at}"
      @purchased = PurchasedItem.where(history: history)
      @purchased.each do |item|
        puts "\t\tItem: #{item.product.title}, Q: #{item.quantity}, total_cost: #{item.total_cost}"
      end
      puts "\tFinal Cost: #{history.final_cost}"
    end
  end
  private
    def user_present
      if user.nil?
        errors.add(:user, 'is not valid')
      end
    end

    def finalize
      @final_cost = 0
      self[:purchased_items].each do |item|
        @final_cost = @final_cost + item.total_cost
      end
      self[:final_cost] = @final_cost
    end

end

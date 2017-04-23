class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  # validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validate :product_present
  validate :cart_present

  # before_create :init
  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total_price
    unit_price * quantity
  end

  def quantity
    if persisted?
      self[:quantity]
    else
      0
    end
  end

  private
    def product_present
      if product.nil?
        errors.add(:product, 'is not valid')
      end
    end

    def cart_present
      if cart.nil?
        errors.add(:cart, 'is not valid')
      end
    end

    def finalize
      self[:quantity] = quantity
      self[:unit_price] = unit_price
      self[:total_price] = quantity * self[:unit_price]
    end
end

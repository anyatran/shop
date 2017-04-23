class PurchasedItem < ApplicationRecord
  belongs_to :history
  belongs_to :product

  validate :product_present
  validate :history_present
  
  private
    def product_present
      if product.nil?
        errors.add(:product, 'is not valid')
      end
    end

    def history_present
      if history.nil?
        errors.add(:history, 'is not valid')
      end
    end

end

class Product < ApplicationRecord
  validates :title, presence: true, length: {maximum: 255}
  validates :price, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }
  validates :available_inventory, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end

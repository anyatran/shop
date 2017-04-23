class Product < ApplicationRecord
  validates :title, presence: true, length: {maximum: 255}
  validates :price, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }
  validates :available_inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.view_inventory
    @products = Product.all
    @products.each do |product|
      row = "Title: #{product.title}"
      row = row + "\t\t Price: #{product.price}"
      row = row + "\t\t A_I: #{product.available_inventory}"
      puts "#{row}"
    end
  end
end

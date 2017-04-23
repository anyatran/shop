class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.references :product, foreign_key: true
      t.references :cart, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price, precision: 12, scale: 2
      t.decimal :total_price, precision: 12, scale: 2

      t.timestamps
    end
  end
end

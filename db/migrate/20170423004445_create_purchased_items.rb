class CreatePurchasedItems < ActiveRecord::Migration[5.0]
  def change
    create_table :purchased_items do |t|
      t.references :history, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.decimal :total_cost, precision: 8, scale: 2

      t.timestamps
    end
  end
end

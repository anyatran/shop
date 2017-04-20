class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.decimal :price, precision: 8, scale: 2, null: false
      t.string :title, limit: 255, null: false
      t.integer :available_inventory, null: false

      t.timestamps
    end
  end
end

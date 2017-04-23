class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.boolean :purchased
      t.decimal :subtotal, precision: 12, scale: 2
      t.decimal :tax, precision: 12, scale: 2
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

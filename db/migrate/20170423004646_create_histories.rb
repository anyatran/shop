class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.references :user, foreign_key: true
      t.decimal :final_cost, precision: 8, scale: 2

      t.timestamps
    end
  end
end

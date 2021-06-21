class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.string :total, default: 0
      t.string :tax, default: 0
      t.references :product
      t.integer :quantity
      t.references :customer
      t.references :order

      t.timestamps
    end
  end
end

class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
    	t.integer :status
      t.string :total, default: 0
      t.string :discount_value, default: 0
      t.references :discount, null: true

      t.timestamps
    end
  end
end

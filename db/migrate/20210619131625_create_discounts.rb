class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.string :title, default: ""
    	t.integer :product_ids, array: true, default: []
      t.integer :value, default: 0
      t.timestamps
    end
  end
end

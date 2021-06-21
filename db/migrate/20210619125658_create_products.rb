class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
    	t.string :title, null: false
    	t.string :description
    	t.text  :detail
    	t.integer :status, null: false
    	t.boolean :free, default: false
    	t.integer :vat, default: 0
    	t.integer :quantity, default: 1
    	t.references :category, index: true
      t.string :price, null: false

      t.timestamps
    end
    add_index :products, :title, unique: true
  end
end

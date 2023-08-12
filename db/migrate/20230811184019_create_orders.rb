class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :postcode, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :payment_method, null: false
      t.integer :shipping_fee, null: false
      t.integer :total_amount, null: false
      t.timestamps
    end
  end
end

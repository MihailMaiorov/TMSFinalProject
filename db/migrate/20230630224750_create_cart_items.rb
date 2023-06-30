class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.bigint :cart_id
      t.bigint :product_id
      t.bigint :quantity

      t.timestamps
    end
  end
end

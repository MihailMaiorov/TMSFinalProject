class DropTableCarts < ActiveRecord::Migration[7.0]
  def change
    drop_table :carts do |t|
      t.bigint :user_id
      t.timestamps null: false
    end
  end
end

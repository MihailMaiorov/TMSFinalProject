class RemoveColumnCartIdFromCartItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :cart_items, :cart_id
  end
end

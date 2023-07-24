# frozen_string_literal: true

class AddUserIdIndexToCartItems < ActiveRecord::Migration[7.0]
  def change
    add_index :cart_items, :user_id
  end
end

# frozen_string_literal: true

class AddIndexToCartItems < ActiveRecord::Migration[7.0]
  def change
    add_index :cart_items, :cart_id
    add_index :cart_items, :product_id
  end
end

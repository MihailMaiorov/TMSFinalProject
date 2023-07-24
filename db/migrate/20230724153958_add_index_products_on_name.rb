# frozen_string_literal: true

class AddIndexProductsOnName < ActiveRecord::Migration[7.0]
  def change
    add_index :products, :name
  end
end

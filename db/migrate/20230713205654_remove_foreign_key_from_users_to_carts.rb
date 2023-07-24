# frozen_string_literal: true

class RemoveForeignKeyFromUsersToCarts < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :carts, :users
  end
end

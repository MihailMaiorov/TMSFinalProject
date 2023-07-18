# frozen_string_literal: true

class AddIndexToCategories < ActiveRecord::Migration[7.0]
  def change
    add_index :categories, :title
  end
end

# frozen_string_literal: true

class AddColumnStatusToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :status, :string
  end
end

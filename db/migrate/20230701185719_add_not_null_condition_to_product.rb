# frozen_string_literal: true

class AddNotNullConditionToProduct < ActiveRecord::Migration[7.0]
  def change
    execute "UPDATE products SET status = 'in stock' WHERE status IS NULL;"
    execute "ALTER TABLE products ALTER COLUMN status SET DEFAULT 'in stock', ALTER COLUMN status SET NOT NULL;"
  end
end

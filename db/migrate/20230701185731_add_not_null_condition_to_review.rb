# frozen_string_literal: true

class AddNotNullConditionToReview < ActiveRecord::Migration[7.0]
  def change
    execute 'UPDATE reviews SET archived = false WHERE archived IS NULL;'
    execute 'ALTER TABLE reviews ALTER COLUMN archived SET DEFAULT false, ALTER COLUMN archived SET NOT NULL;'
  end
end

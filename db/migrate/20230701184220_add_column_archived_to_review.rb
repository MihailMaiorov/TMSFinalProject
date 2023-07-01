class AddColumnArchivedToReview < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :archived, :boolean
  end
end

class AddReviewAlertToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :review_alert, :boolean
  end
end

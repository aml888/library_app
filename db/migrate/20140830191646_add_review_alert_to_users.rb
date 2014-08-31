class AddReviewAlertToUsers < ActiveRecord::Migration
  def change
    add_column :users, :review_alert, :boolean
  end
end

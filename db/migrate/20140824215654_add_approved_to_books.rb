class AddApprovedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :approved, :boolean
  end
end

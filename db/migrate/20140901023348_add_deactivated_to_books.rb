class AddDeactivatedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :deactivated, :boolean
  end
end

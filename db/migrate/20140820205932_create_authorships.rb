class CreateAuthorships < ActiveRecord::Migration
  def change
    create_table :authorships do |t|
      t.integer :book_id
      t.integer :author_id
      t.string :number

      t.timestamps
    end
  end
end

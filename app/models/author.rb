class Author < ActiveRecord::Base
	has_many :authorships
	has_many :books, through: :authorships
	belongs_to :book
end

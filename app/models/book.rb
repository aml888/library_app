class Book < ActiveRecord::Base
	has_many :authorships
	has_many :authors, through: :authorships
	mount_uploader :picture, PictureUploader
	validates :title, :ISBN, :picture, presence: {message: 'must not be blank'}
	has_many :reviews
	accepts_nested_attributes_for :authors
end

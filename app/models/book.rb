class Book < ActiveRecord::Base
	mount_uploader :picture, PictureUploader
	validates :title, :author, :ISBN, :picture, presence: {message: 'must not be blank'}
	has_many :reviews
end

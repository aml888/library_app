class Book < ActiveRecord::Base
	belongs_to :user
	has_many :authorships
	has_many :authors, through: :authorships
	mount_uploader :picture, PictureUploader
	validates :title, :ISBN, :picture, presence: {message: 'must not be blank'}
	has_many :reviews
	accepts_nested_attributes_for :authors
	has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower
    acts_as_taggable
	
	
end

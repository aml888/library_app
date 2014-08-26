class Book < ActiveRecord::Base
	belongs_to :user
	has_many :authorships 
	has_many :authors, through: :authorships
	mount_uploader :picture, PictureUploader
	has_many :reviews
	accepts_nested_attributes_for :authors
	has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower
    acts_as_taggable
	scope :approved, -> { where(approved: true) }
	scope :pending_approval, -> { where(approved: [false, nil]) }

	validates :title, :ISBN, :picture, presence: {message: 'must not be blank'}
	
	def self.search(search)
		if search
			where('title LIKE ?', "%#{search}%")
		else
		
			all
		end
	end
	
	def approve!
		 self.approved = true
		self.save
	end

end
	

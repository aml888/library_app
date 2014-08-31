class User < ActiveRecord::Base
	rolify
	has_many :books
	has_many :reviews
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_books, through: :relationships, source: :followed
	ratyrate_rater
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
	def following?(book)
		relationships.find_by(followed_id: book.id)
	end

	def follow!(book)
		relationships.create!(followed_id: book.id)
	end		 

	def unfollow!(book)
		relationships.find_by(followed_id: book.id).destroy
	end  
end

		 

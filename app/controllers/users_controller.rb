class UsersController < ApplicationController
	def following
		@title = "Followed books"
		@user = User.find(params[:id])
		@books = @user.followed_books.paginate(page: params[:page])
		render 'show_follow'
	end

end

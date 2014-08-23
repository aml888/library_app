class UsersController < ApplicationController
	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.followed_books.paginate(page: params[:page])
		render 'show_follow'
	end

end

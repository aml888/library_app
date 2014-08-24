class RelationshipsController < ApplicationController
   before_action :signed_in_user
  
  def create
    @book = Book.find(params[:relationship][:followed_id])
    current_user.follow!(@book)
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end

  def destroy
    @book = Relationship.find(params[:id]).followed
    current_user.unfollow!(@book)
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end
end
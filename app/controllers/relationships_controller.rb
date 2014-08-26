class RelationshipsController < ApplicationController
  def create
    @book = Book.find(params[:relationship][:followed_id])
    current_user.follow!(@book)
    redirect_to @book
  end

  def destroy
    @book = Relationship.find(params[:id]).followed
    current_user.unfollow!(@book)
    redirect_to @book
  end
end
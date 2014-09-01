class ReviewsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
	@book = Book.find(params[:book_id])
	if @book.deactivated
		flash[:notice] = "This book has been deactivated. You cannot add reviews or ratings."
		redirect_to book_path(@book)
	else
		@review = @book.reviews.create(review_params)
	    redirect_to book_path(@book)
	end
  end
	
	
  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @book = Book.find(params[:book_id])
    @review = @book.reviews.find(params[:id])
    @review.destroy
    redirect_to book_path(@book)
  end   
  
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:user_name, :body, :user_id, :book_id)
    end
end


class BooksController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  
  
  # GET /books
  # GET /books.json
  def index 
	@books = Book.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
	@approved_books = Book.approved 
	@pending_books = Book.pending_approval
  end

  # GET /books/1
  # GET /books/1.json
  def show
	@book = Book.find(params[:id])
	@reviews = @book.reviews.all
	@review = @book.reviews.build
	@rates = @book.rates.all
  end

  # GET /books/new
  def new
	@book = Book.new
	@book.authors.build
  end

  # GET /books/1/edit
  def edit
  
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
	@book.user = current_user

    respond_to do |format|
      if @book.save
        format.html { render 'show_pending', notice: 'Your book entry has been submitted to the administrator for approval.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.user == current_user && @book.update(book_params)
		format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
		flash[:notice] = "You are not authorized to edit this page."
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    respond_to do |format|
	  if @book.user == current_user
		@book.destroy  
		format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
		format.json { head :no_content }
	  else
	    format.html { redirect_to books_url, notice: 'You are not authorized to delete this book.' }
		format.json { head :no_content }
	
	  end
	end  
  end

  def approve
	return redirect_to books_url if @book.approve!
	redirect_to books_url, notice: 'Problem approving topic'
  end
 
 
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
	 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :picture, :ISBN, :description, :tag_list, author_ids: [], authors_attributes: [:name])
	  
    end
	
	 def sort_column
		Book.column_names.include?(params[:sort]) ? params[:sort] : "name"
	end
	
	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
	
end
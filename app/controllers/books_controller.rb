class BooksController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource
  
  # GET /books
  # GET /books.json
  def index 
	#@books = Book.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, :page => params[:page])
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
	@book.authors.build
  end

  # GET /books/1/edit
  def edit
  
  end

  # POST /books
  # POST /books.json
  def create
    @book.user = current_user

    respond_to do |format|
      if @book.save
        format.html { render 'show_pending', notice: 'Your book entry has been submitted to the administrator for approval.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
		format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    respond_to do |format|
	  if @book.destroy  
		format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
		format.json { head :no_content }
	  end
	end  
  end

  def approve
	return redirect_to books_url if @book.approve!
	redirect_to books_url, notice: 'Problem approving book'
  end
   
  private
   

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :picture, :ISBN, :description, :tag_list, author_ids: [], authors_attributes: [:name])
	  
    end
	
	 def sort_column
		Book.column_names.include?(params[:sort]) ? params[:sort] : "title"
	end
	
	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
	
end
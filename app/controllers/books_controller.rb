class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit]
  def top
  end

  def index
    @book = Book.new
    @books =Book.all
  end

  def about
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @book_comment = BookComment.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
 if @book.save
    redirect_to book_path(@book)
    flash[:notice]= "You have creatad book successfully."
  else
    @books =Book.all
    render action: :index
  end
end

  def edit
    @book = Book.find(params[:id])
  if @book.user_id != current_user.id
    redirect_to books_path
  end

  end

  def update
      @book = Book.find(params[:id])
   if @book.update(book_params)
     redirect_to book_path(@book)
     flash[:notice]= "You have updated book successfully."
   else
    render action: :edit
   end


  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
    flash[:alert] = "Signed out successfully."
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

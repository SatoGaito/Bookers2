class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:destroy, :edit, :update]

  def index
    @books = Book.all
    @Book = Book.new
    @user = current_user 
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @Book = Book.new
  end

  def new
  end

  def create
    @Book = Book.new(book_params)
    @Book.user_id = current_user.id
    if @Book.save
      redirect_to book_path(@Book), notice: 'You have creatad book successfully.'
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params) 
      redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end
  end
end

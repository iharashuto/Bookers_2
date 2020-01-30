class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @book = Book.new
    @users =User.all
  end

  def show
  	@user = User.find(params[:id])
    @book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  if @user.id != current_user.id
     redirect_to user_path(current_user)
  end
  end

  def update
  	 @user = User.find(params[:id])

  if @user.update(user_params)
    redirect_to user_path(@user)
    flash[:notice]="You have updated user successfully."
  else
    render action: :edit
  end

  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    if @user.save
      redirect_to users_path
      flash[:notice]="Welcome! You have signed up successfully."
    else
      render :new
    end
  end

   private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

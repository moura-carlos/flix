class UsersController < ApplicationController
  before_action :require_sign_in, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Your account was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # The @user is already set up by the before action 'require_correct_user'
    # @user = User.find(params[:id])
  end

  def update
    # The @user is already set up by the before action 'require_correct_user'
    # @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Your account information was successfully updated!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # The @user is already set up by the before action 'require_correct_user'
    # @user = User.find(params[:id])
    if @user.destroy
      session[:user_id] = nil
      redirect_to movies_url, status: :see_other, alert: "Your account was successfully deleted!"
    else
      render :show, danger: "Oops, something went wrong. Please, try again!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    # user.id == session[:user_id]
    unless current_user?(@user)#current_user == @user
      redirect_to root_url, status: :see_other
    end
  end
end

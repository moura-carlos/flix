class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "Your account was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Your account information was successfully updated!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to movies_url, status: :see_other, alert: "Your account was successfully deleted!"
    else
      render :show, danger: "Oops, something went wrong. Please, try again!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end

end

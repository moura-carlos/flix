class ApplicationController < ActionController::Base
  add_flash_types(:danger)


  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_sign_in
    unless current_user
      session[:intended_url] = request.url
      redirect_to signin_url, alert: "You have to sign in first!"
    end
  end

  # checking if the current logged in user is the same as the 'user' we are trying to
  # edit or delete
  def current_user?(user)
    current_user == user
  end

  def require_admin
    redirect_to root_url, alert: "Unauthorized!" unless current_user.admin?
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user
  helper_method :current_user?
  helper_method :current_user_admin?
end

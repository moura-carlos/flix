module ApplicationHelper
  def get_application_name
    Rails.application.class.name.split("::")[0]
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

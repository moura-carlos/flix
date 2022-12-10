module ApplicationHelper
  def get_application_name
    Rails.application.class.name.split("::")[0]
  end
end

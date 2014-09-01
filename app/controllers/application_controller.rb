class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def new_session_path(scope)
	new_user_session_path	
  end
  
  def authenticate_admin!
	redirect_to new_user_session_path unless current_user.is_admin?
  end
  
  rescue_from CanCan::AccessDenied do |exception|
	redirect_to :back, alert: exception.message
  end
  
  
end

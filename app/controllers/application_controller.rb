class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def logged_in?
    current_user.present?
   end
   helper_method :logged_in?

   def current_user
     @current_user ||= User.find_by_id session[:user_id]
   end
   helper_method :current_user

   def login! user
     session[:user_id] = user.try(:id)
   end

   def logout!
     session[:user_id] = nil
   end
end

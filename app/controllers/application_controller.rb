class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # handle 404 errors with an exception as well
  rescue_from ActiveRecord::RecordNotFound do |exception|

    # consider creating your own 404 page within home and redirecting there...
    
    flash[:error] = "Seek and you shall find... but not this time"
    redirect_to home_path
  end

  private
  def current_employee
    @current_employee ||= Employee.find(session[:employee_id]) if session[:employee_id]
  end
  
  helper_method :current_employee

  def logged_in?
    current_employee
  end
  helper_method :logged_in?

  def check_login
    redirect_to login_url, alert: "You need to log in to view this page." if current_employee.nil?
  end
  
end

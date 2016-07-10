class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
	 devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password) }
	 devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :city, :province, :postal_code, :telephone, :is_female, :date_of_birth) }
  end
end

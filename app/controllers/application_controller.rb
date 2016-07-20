class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})
    site_name   = "Grassy"
    title       = [controller_name, action_name].join(" ")
    description = "Grassy Wellness Society wants to ensure members have access and availability to safe, affordable cannabis products for medical purposes"
    image       = options[:image] || "https://grassyvnc.s3.amazonaws.com/uploads/slideshow/slideshow/1/large_slide-1.jpg"
    current_url = request.url

    # Let's prepare a nice set of defaults
    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[grassy vancouver marijuana dispensary delivery],
      twitter: {
        site_name: site_name,
        site: '@grassy',
        card: 'summary',
        description: description,
        image: image
      },
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end

  protected

  def configure_permitted_parameters
	 devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password) }
	 devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :city, :province, :postal_code, :telephone, :is_female, :date_of_birth) }
  end
end

# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
	address: "smtp.gmail.com",
	port: 587,
	domain: "grassy.ca",
	authentication: "plain",
	user_name: "marko.manojlovic.bg@gmail.com",
	password: ENV["gmail_password"],
	enable_starttls_auto: true
  # :user_name => ENV["sendgrid_username"],
  # :password => ENV["sendgrid_password"],
  # :domain => "grassy.ca",
  # :address => "smtp.sendgrid.net",
  # :port => 587,
  # :authentication => :plain,
  # :enable_starttls_auto => true
}
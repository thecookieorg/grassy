# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
	address: "smtp.gmail.com",
	port: 587,
	domain: "domain.of.sender.net",
	authentication: "plain",
	user_name: "marko.manojlovic.bg@gmail.com",
	password: "Mi$k0P1$k0",
	enable_starttls_auto: true
  #:user_name => 'your_sendgrid_username',
  #:password => 'your_sendgrid_password',
  #:domain => 'yourdomain.com',
  #:address => 'smtp.sendgrid.net',
  #:port => 587,
  #:authentication => :plain,
  #:enable_starttls_auto => true
}
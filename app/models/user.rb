class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :store_policies
  has_many :orders

  # Sending welcome email that I created under user_notifier.rb
  after_create :send_welcome_email
  def send_welcome_email
  	UserNotifier.send_signup_email(self).deliver
  end
end

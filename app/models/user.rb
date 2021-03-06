class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :store_policies
  has_many :orders
  has_many :slideshows
  has_many :staticimages
  has_many :visits

  #geocoded_by :users_address
  #after_validation :geocode          # auto-fetch coordinates

  # Sending welcome email that I created under user_notifier.rb
  after_create :send_welcome_email
  def send_welcome_email
   	UserNotifier.send_signup_email(self).deliver
    UserNotifier.send_signup_email_to_grassy_owner(self).deliver
  end
end

class StorePolicy < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :name, :content
end

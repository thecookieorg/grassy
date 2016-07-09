class Staticimage < ActiveRecord::Base
	mount_uploader :staticpic, StaticpicUploader #tells rails to use this uploader for this model
	belongs_to :user
end

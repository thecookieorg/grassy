class Slideshow < ActiveRecord::Base
	mount_uploader :slideshow, SlideshowUploader #tells rails to use this uploader for this model
	belongs_to :user
end

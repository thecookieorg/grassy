class PagesController < ApplicationController
  def index
  	@categories = Category.all
  	@slideshows = Slideshow.all
  	@first_slide = Slideshow.first
  	@second_slide = Slideshow.second
  	@third_slide = Slideshow.third
  end

  def privacy_policy
  end

  def delivery_policy
  end

  def terms_of_service
  end
end

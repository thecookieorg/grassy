class LandingController < ApplicationController
  include CurrentCart
  before_action :set_cart
  
  def index
  	@page_title = "Grassy Products"
  	@categories = Category.all
  	@products = Product.order(:name)
  	@landing_static_image = Staticimage.first
  end
end

class LandingController < ApplicationController
  include CurrentCart
  before_action :set_cart
  
  def index
  	@categories = Category.all
  	@products = Product.order(:name)
  end
end

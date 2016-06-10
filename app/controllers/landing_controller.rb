class LandingController < ApplicationController
  def index
  	@categories = Category.all
  	@products = Product.all.limit(4)
  end
end

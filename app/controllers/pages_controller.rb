class PagesController < ApplicationController
  def index
  	@categories = Category.all
  end

  def privacy_policy
  end

  def delivery_policy
  end

  def terms_of_service
  end
end

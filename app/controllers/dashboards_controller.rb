class DashboardsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  	# I didn't actually need the code below. It raises an error => wrong number of arguments (given 1, expected 2+)
  	# I am not sure what that error is. authorize! :index works for products_controller, hmmmmmmmmm!
  	#authorize! :index 
  end
end

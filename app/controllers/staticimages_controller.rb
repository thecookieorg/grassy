class StaticimagesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_staticimage, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource

	def index
		@staticimage = Staticimage.all
	end

	def show
	end

	def new
		@staticimage = current_user.staticimages.build
	end

	def edit
	end

	def create
		@staticimage = current_user.staticimages.build(staticimage_params)

		respond_to do |format|
			if @staticimage.save
				format.html { redirect_to @staticimage, notice: 'You have added a static image' }
			else
				format.html { render :new }
			end
		end
	end

	def update
		respond_to do |format|
			if @staticimage.update(staticimage_params)
				format.html { redirect_to @staticimage, notice: 'Image was successfully updated.' }
			else
				format.html { render :edit }
			end
		end
	end

	def destroy
		@staticimage.destroy
		respond_to do |format|
			format.html { redirect_to staticimages_url, notice: 'Image was deleted.' }
		end
	end

	private

		def set_staticimage
			@staticimage = Staticimage.find(params[:id])
		end

		def staticimage_params
			params.require(:staticimage).permit(:staticpic)
		end

end
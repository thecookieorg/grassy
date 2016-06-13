class StorePoliciesController < ApplicationController
  before_action :set_store_policy, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /store_policies
  # GET /store_policies.json
  def index
    @store_policies = StorePolicy.all
  end

  # GET /store_policies/1
  # GET /store_policies/1.json
  def show
  end

  # GET /store_policies/new
  def new
    #@store_policy = StorePolicy.new
    @store_policy = current_user.store_policies.build
  end

  # GET /store_policies/1/edit
  def edit
  end

  # POST /store_policies
  # POST /store_policies.json
  def create
    #@store_policy = StorePolicy.new(store_policy_params)
    @store_policy = current_user.store_policies.build(store_policy_params)

    respond_to do |format|
      if @store_policy.save
        format.html { redirect_to @store_policy, notice: 'Store policy was successfully created.' }
        format.json { render :show, status: :created, location: @store_policy }
      else
        format.html { render :new }
        format.json { render json: @store_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /store_policies/1
  # PATCH/PUT /store_policies/1.json
  def update
    respond_to do |format|
      if @store_policy.update(store_policy_params)
        format.html { redirect_to @store_policy, notice: 'Store policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @store_policy }
      else
        format.html { render :edit }
        format.json { render json: @store_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_policies/1
  # DELETE /store_policies/1.json
  def destroy
    @store_policy.destroy
    respond_to do |format|
      format.html { redirect_to store_policies_url, notice: 'Store policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_policy
      @store_policy = StorePolicy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_policy_params
      params.require(:store_policy).permit(:name, :content)
    end
end

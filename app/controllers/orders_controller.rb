require 'httparty'
require 'active_support/all'
require 'json'

class OrdersController < ApplicationController
  include CurrentCart
  before_action :authenticate_user!
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    #@orders = Order.all
    if current_user.admin?
      @orders = Order.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
    else
      @orders = current_user.orders.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    end
    #@categories = Category.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: "Your cart is empty"
      return
    end

    @order = current_user.orders.build


=begin

THIS IS MY ITEMS ARRAY OF OBJECTS FROM GET SWIFT DOCUMENTATION
    "items": [
      {
        "quantity": 1,
        "sku": "sample string 2",
        "description": "sample string 3",
        "price": 4.0
      },
      {
        "quantity": 1,
        "sku": "sample string 2",
        "description": "sample string 3",
        "price": 4.0
      }
    ]
=end



    # REFACTOR THIS CODE!!!
    # DON'T USE CLASS INSTANCE VARIABLES @@, USE LOCAL VARIABLES INSTEAD
    # TRY TO MOVE THIS LOGIC BELOW INTO THE CREATE ACTION
    # USE $items = Array.new instead of ||= [] BECAUSE WE DON'T HAVE TO APPEND ANYTHING TO EXISTING ARRAY.
    # OUR ARRAYS ARE BEING CREATED EACH TIME AN ORDER IS MADE.
    # $items is a global variable. Use local variable if this works under CREATE action
    @@items ||= []

    @cart.line_items.each do |line_item|
      item_hash = {
          :quantity => line_item.quantity,
          :sku => line_item.product.sku,
          :description => "#{line_item.product.name}",
          :price => line_item.product.price * line_item.quantity
      }

      @@items.push(item_hash)

      # THIS BELOW DOESN'T WORK BECAUSE IT IS CREATING
      # A NEW HAS EACH TIME I PUSH IT TO THE ARRAY
      # SO MY END RESULT IN THIS TRY WAS LIKE THIS:
      # [{quantity: 3}, {sku: SKU_NAME}, {description: Description}]
      #quantity = { :quantity => line_item.quantity }
      #sku = { :sku => line_item.product.sku }
      #description = { :description => "#{line_item.product.name}" }
      #price = { :price => line_item.product.price }
      
      # Push hashes into array
      #@@items << quantity
      #@@items << sku
      #@@items << description
      #@@items << price
    end

    @categories = Category.all
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    #@order = Order.new(order_params)
    @order = current_user.orders.build(order_params)
    @order.add_line_items_from_cart(@cart)
    
    @amount = @cart.total_price.to_i * 100

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Grassy Payment',
      currency: 'cad'
    )

    # GET SWIFT INTEGRATION
    # api_key = ENV["swift_api_key"]
    
    dropoffAddress = "#{current_user.street_address}, #{current_user.city}, #{current_user.postal_code}, #{current_user.province}"
    HTTParty.post("https://app.getswift.co/api/v2/deliveries",
          {
              :body => {
                    "apiKey": ENV["swift_api_key"],
                    "booking":{
                        "items": @@items,
                        "pickupDetail": {
                            "name": "Grassy",
                            "phone": "7788368819",
                            "address": "375 Water Street, Vancouver, BC V6B 5C6"
                        },
                        "dropoffDetail": {
                            "name": current_user.name,
                            "phone": current_user.telephone,
                            "address": dropoffAddress
                        }
                    }
                }.to_json,  
              :headers => { 'Content-Type' => 'application/json' }
          }
      )


    respond_to do |format|
      if @order.save

        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        UserNotifier.send_order_confirmation(@order).deliver # sends order confirmation email to user
        UserNotifier.send_order_confirmation_to_grassy_owner(@order).deliver # sends order confirmation email to user
        format.html { redirect_to root_url, notice: 'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_url and return
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:pay_type, :address, :stripeEmail, :stripeToken, :stripe_card_token, :product_id)
    end

end

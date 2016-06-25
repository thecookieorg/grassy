require 'httparty'
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

    #@order = Order.new
    @order = current_user.orders.build

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
    products = @order.add_line_items_from_cart(@cart)
    api_key = ENV["swift_api_key"]
    
    item_elements = []

    items = products.each { |i| item_elements.push(i) }
    puts items
=begin
    HTTParty.post("https://app.getswift.co/api/v2/deliveries",
          {
            :body => {
                        "apiKey": api_key,
                        "booking":{
                            "items": items,
                            "pickupDetail": {
                                "name": "Marko",
                                "phone": "604 356 8259",
                                "address": "3456 Wellington Crescent",
                                "additionalAddressDetails": {
                                  "stateProvince": "British Columbia",
                                  "country": "Canada",
                                  "postcode": "V7R3B4",
                                  "latitude": 49.3405554,
                                  "longitude": -123.1045127
                                }
                            },
                            "dropoffDetail": {
                                "name": current_user.name,
                                "phone": current_user.telephone,
                                "address": current_user.street_address,
                                "additionalAddressDetails": {
                                  "stateProvince": current_user.province,
                                  "country": "Canada",
                                  "postcode": current_user.postal_code,
                                  "latitude": current_user.latitude,
                                  "longitude": current_user.longitude
                                }
                            }
                        }
                    }.to_json,
            :headers => { 'Content-Type' => 'application/json' }
          }
      )
=end

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
      params.require(:order).permit(:pay_type, :address, :stripeEmail, :stripeToken, :stripe_card_token)
    end

end

class Public::OrdersController < ApplicationController

  def new
    @customer = current_customer
    @order = Order.new

  end

  def complete
    @customer = current_customer
  end

  def index
    @customer = current_customer
    @orders = current_customer.orders

  end

  def show
    @customer = current_customer
    @order = Order.find(params[:id])
  end

  def confirm
     @customer = current_customer
     @order = Order.new(order_params)

     if params[:order][:address_option] == "0"
        @order.postcode = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.first_name + current_customer.last_name
     elsif params[:order][:address_option] == "1"
        @order.postcode = params[:order][:postcode]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
     else
            render 'new'
     end

     @cart_items = current_customer.cart_items
     @order.customer_id = current_customer.id
     @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }

  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
       @order_details = OrderDetail.new #初期化宣言
       @order_details.item_id = cart_item.item_id #商品idを注文商品idに代入
       @order_details.number = cart_item.amount #商品の個数を注文商品の個数に代入
       @order_details.price = (cart_item.item.price*1.1).floor #消費税込みに計算して代入
       @order_details.order_id =  @order.id #注文商品に注文idを紐付け
       @order_details.save #注文商品を保存
    end

    current_customer.cart_items.destroy_all

    redirect_to orders_complete_path
  end

  private
    def order_params
        params.require(:order).permit(:customer_id, :postcode, :address, :name, :payment_method, :shipping_fee, :total_amount, :address_option, :number)
    end

end

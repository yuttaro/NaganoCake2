class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
    @customer = current_customer
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to cart_items_path
    elsif @cart_item.save
      @cart_items = current_customer.cart_items
      redirect_to cart_items_path
    else
      redirect_to cart_items_path
    end
  end

  def update
        cart_item = CartItem.find(params[:id])
        cart_item.update(cart_item_params)
        @cart_items = CartItem.all
        redirect_to cart_items_path
  end

  def destroy
        cart_item = CartItem.find(params[:id])
        cart_item.destroy
        redirect_to cart_items_path
  end

  def destroy_all
        cart_items = current_customer.cart_items
        cart_items.destroy_all
        redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount,)
  end

end

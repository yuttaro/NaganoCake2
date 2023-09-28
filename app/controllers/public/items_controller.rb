class Public::ItemsController < ApplicationController

  def index
    @customer = current_customer
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @customer = current_customer
    @item = Item.find(params[:id])
    @cart_items = CartItem.new
  end


end

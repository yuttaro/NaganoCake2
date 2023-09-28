class Public::HomesController < ApplicationController
  def top
    @items = Item.all.limit(4)
    @customer = current_customer
  end

  def about

  end

end

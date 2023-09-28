class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  attr_accessor :address_option
  enum payment_method: { credit_card: 0, transfer: 1 }

  def subtotal
    item.with_tax_price * number
  end
end

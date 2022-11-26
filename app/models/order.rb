class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum method_of_payment: {credit_card: 0, transfer: 1}
  enum order_status: {waiting: 0, confirmation: 1, production: 2, preparing: 3, shipped: 4}

  def address_display
    '〒' + post_code + ' ' + address + ' ' + name
  end
end

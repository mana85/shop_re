class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :quantity, presence: true

  def sub_total
    quantity*product.with_tax_price
  end

  def quantity_options
    options = []
    (self.quantity + 11).times do |count|
      options << [count, count]
    end
    return options
  end

  def self.total_price(customer)
    CartItem.where(customer_id: customer.id).inject(0){|sum, cart_item| sum + cart_item.sub_total}
  end
end

class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  enum making_status: {can_not_start: 0, waiting_for_production: 1, production: 2, completed: 3}

  def sub_total
    quantity*product.with_tax_price
  end

  def self.total_price(order)
    OrderDetail.where(order_id: order.id).inject(0){|sum, order_detail| sum + order_detail.sub_total}
  end

end

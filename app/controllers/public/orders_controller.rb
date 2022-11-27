class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
    @shipping_addresses = @customer.shipping_addresses
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == '0'
      @order.post_code = current_customer.post_code
      @order.name = current_customer.first_name + current_customer.last_name
      @order.address = current_customer.address
    elsif params[:order][:select_address] == '1'
      @address = ShippingAddress.find(params[:order][:shipping_address_id])
      @order.post_code = @address.post_code
      @order.name = @address.name
      @order.address = @address.address
    elsif params[:order][:select_address] == '2'
      @order.customer_id = current_customer.id
    end
    @cart_items = current_customer.cart_items.all
    @total_price = CartItem.total_price(current_customer)
    @order_new = Order.new
    render :confirm
  end

  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order_datails = OrderDetail.new
      @order_details.order_id = @order.id
      @order_details.product_id = cart_item.product.id
      @order_datails.tax_price = cart_item.product.with_tax_price
      @order_details.quantity = cart_item.quantity
      @order_details.making_status = 0
      @order_datails.save
    end

    CartItem.destroy_all
    redirect_to "/orders/complete"
  end

  def complete
  end

  def index
    @customer = current_customer
    @orders = @customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @total_price = OrderDetail.total_price(@order)
    @order_details = OrderDetail.where(order_id: params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:customer_id,:order_status,:name,:post_code,:address,:postage,:total_payment,:method_of_payment)
  end


end

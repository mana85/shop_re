class Public::ShippingAddressesController < ApplicationController

  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = current_customer.shipping_addresses.all
  end

  def create
    @shipping_address = current_customer.shipping_addresses.new(shipping_address_params)
    @shipping_address.save
    redirect_to request.referer
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.update(shipping_address_params)
    redirect_to shipping_addresses_path
  end

  def destroy
    ShippingAddress.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(:post_code,:address,:name,:phone_number)
  end
end

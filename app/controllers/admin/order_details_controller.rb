class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    if @order_detail.making_status == "production"
      @order_detail.order.update(order_status: 2)
    elsif OrderDetail.where(making_status: "completed", order_id: @order_detail.order_id).count == @order_detail.order.order_details.count
      @order_detail.order.update(order_status: 3)
    end
    redirect_to request.referer
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end

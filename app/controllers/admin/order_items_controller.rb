class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  def update
    order_item = OrderItem.find(params[:id])
    order_item.update(admin_order_item_params)
    redirect_to admin_order_path(order_item.order)
  end

  private
  def admin_order_item_params
    params.require(:order_item).permit(:production_status)
  end
end

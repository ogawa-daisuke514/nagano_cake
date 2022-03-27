class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  def update
    order_item = OrderItem.find(params[:id])
    order_item.update(admin_order_item_params)
    od = order_item.order
    if order_item.production_status != "disabled"
      st = Order.order_statuses.key(od.production_order_status)
      od.update(order_status: st)
    end
    redirect_to admin_order_path(order_item.order), notice: "制作ステータスを正常に更新しました。"
  end

  private
  def admin_order_item_params
    params.require(:order_item).permit(:production_status)
  end
end

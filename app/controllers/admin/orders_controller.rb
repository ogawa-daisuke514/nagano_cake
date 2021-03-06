class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @orders = Order.all.order(created_at: "DESC").page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(admin_order_params)
    if @order.order_status != "wait_for_deposit"
      @order.order_items.each do |oi|
        if oi.production_status == "disabled"
          oi.update(production_status: "wait_for_production")
        end
      end
    end
    redirect_to admin_order_path(@order), notice: "注文ステータスを正常に更新しました。"
  end

  private
  def admin_order_params
    params.require(:order).permit(:order_status)
  end
end

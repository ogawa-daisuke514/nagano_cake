class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(admin_order_params)
    redirect_to admin_order_path(@order)
  end

  private
  def admin_order_params
    params.require(:order).permit(:order_status)
  end
end

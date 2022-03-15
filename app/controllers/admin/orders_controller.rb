class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page])
  end

  def show
  end
end

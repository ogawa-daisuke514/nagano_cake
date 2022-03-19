class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @addresses = current_customer.addresses
    @new_address = Address.new
    @order = Order.new
  end

  def confirm
  end

  def create
  end

  def thanks
  end

  def index
  end

  def show
  end
end

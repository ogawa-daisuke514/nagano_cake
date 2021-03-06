class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "会員情報を正常に保存しました。"
    else
      render :edit
    end
  end

  def orders
    @customer = Customer.find(params[:id])
    @orders = @customer.orders.page(params[:page])
  end

  protected
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana,
      :email, :postal_code, :address, :telephone_number, :is_active)
  end
end

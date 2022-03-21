class Public::AddressesController < ApplicationController

  before_action :authenticate_customer!

  def index
    @address = Address.new
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: "連絡先を正常に追加しました。"
    else
      render :index
    end
  end

  def update
    @address = current_customer.addresses.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "連絡先を正常に保存しました。"
    else
      render :edit
    end
  end

  def destroy
    address = current_customer.addresses.find(params[:id])
    address.destroy
    redirect_to addresses_path, notice: "連絡先を正常に削除しました。"
  end

  private
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end

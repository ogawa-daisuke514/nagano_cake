class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
  @addresses = current_customer.addresses
    @order = Order.new
    @address_type = 0
  end

  def confirm
    @order = current_customer.orders.new(order_params)
    @address_type = params[:order][:address_type].to_i
    case @address_type
    when 0
      set_address(
        @order,
        current_customer.full_name,
        current_customer.postal_code,
        current_customer.address
        )
    when 1
      address = current_customer.addresses.find(params[:order][:address_id].to_i)
      set_address(
        @order,
        address.name,
        address.postal_code,
        address.address
        )
    when 2
    end
    @order.postage = @order.now_postage
    @order.total_fee = current_customer.cart_total + @order.postage
    render :new if !@order.valid?
  end

  def create
    @order = current_customer.orders.new(order_create_params)
    # 検算する。注文確認画面の表示中に値段変動があった場合などに、
    # 表示と違う金額を請求することを避ける。
    postage = @order.now_postage
    total_fee = current_customer.cart_total + postage
    if((total_fee != @order.total_fee) || (postage != @order.postage))
      @order.postage = postage
      @order.total_fee = total_fee
      flash.now[:alert] = "注文を確定できませんでした。以下の内容をもう一度ご確認の上、注文を確定してください(前回の表示から、商品の単価が変更された可能性があります)。"
      render :confirm
    elsif @order.save
      current_customer.order_items.each do |oi|
        oi.order_id = @order.id
        oi.save
      end
      current_customer.destroy_all_cart
      redirect_to orders_thanks_path, notice: "注文を確定しました。"
    else
      redirect_to new_order_path, alert: "注文を確定できませんでした。お手数ですが、もう一度入力してください。"
    end
  end

  def thanks
  end

  def index
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  private
  def set_address(order, name, postal_code, address)
    order.name = name
    order.postal_code = postal_code
    order.address = address
  end
  def order_create_params
    params.require(:order).permit(:name, :postal_code, :address, :postage,
      :total_fee, :order_status, :payment_method)
  end
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end
end

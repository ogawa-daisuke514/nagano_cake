class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    amount = params[:cart_item][:amount].to_i
    cart_item.update(amount: amount)
    redirect_to cart_items_path, notice: "数量を正常に更新しました。"
  end

  def destroy
    current_customer.cart_items.find(params[:id]).destroy
    redirect_to cart_items_path, notice: "カートから商品を削除しました。"
  end

  def destroy_all
    current_customer.destroy_all_cart
    redirect_to cart_items_path, notice: "カートを空にしました。"
  end

  def create
    item_id = params[:cart_item][:item_id].to_i
    amount = params[:cart_item][:amount].to_i
    cart_item = current_customer.cart_items.find_by(item_id: item_id)
    if cart_item
      cart_item.update(amount: cart_item.amount+amount)
    else
      cart_item = current_customer.cart_items.new(cart_item_params)
      cart_item.save
    end
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
end

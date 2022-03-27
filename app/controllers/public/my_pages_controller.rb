class Public::MyPagesController < ApplicationController

  before_action :authenticate_customer!

  def show
  end

  def edit
  end

  def update
    if current_customer.update(customer_params)
      redirect_to my_page_path, notice: "会員情報を更新しました。"
    else
      render :edit
    end
  end

  def withdraw_confirm
  end

  def withdraw
    current_customer.update(is_active: false)
    redirect_to customer_log_out_path # もう一度リダイレクトするのでフラッシュメッセージ不要
  end
  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana,
      :email, :postal_code, :address, :telephone_number)
  end
end

class ApplicationController < ActionController::Base

  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :customer
      root_path
    end
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_orders_path
    when Customer
      root_path
    end
  end

  protected

  def authenticate_customer!
    if customer_signed_in?
      super
    else
      redirect_to new_customer_session_path, alert: "指定のページを表示するには、ログインが必要です。"
    end
  end

  def authenticate_admin!
    if admin_signed_in?
      super
    else
      redirect_to new_admin_session_path, alert: "指定のページを表示するには、管理者ログインが必要です。"
    end
  end
end

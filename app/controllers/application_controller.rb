class ApplicationController < ActionController::Base

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

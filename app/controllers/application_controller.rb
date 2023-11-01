class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後のアクセス先指定
  def after_sign_in_path_for(resource_or_scope)
    # 管理者か？
    if resource_or_scope.is_a?(Admin)

      # はい→ユーザー一覧画面へ
      admin_customers_path
    else

      # いいえ→ルートパス(トップページへ)
      root_path
    end
  end

  # ログアウト後のアクセス先
  def after_sign_out_path_for(resource_or_scope)
    # 管理者か？
    if resource_or_scope == :customer
      # はい→トップページへ
      root_path
    elsif resource_or_scope == :admin

      # 管理者ログイン画面へ
      new_admin_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :is_published])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :is_published])
  end
end

class ApplicationController < ActionController::Base
  # ログイン後に遷移するpathを設定
  def after_sign_in_path_for(resource)
    places_home_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def after_update_path_for(resource)
    user_path(id: current_user.id)
  end

  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップ時にnameとimageのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :image])
  end
end

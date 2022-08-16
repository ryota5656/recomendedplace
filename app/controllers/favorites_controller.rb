class FavoritesController < ApplicationController
  # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）
  before_action :authenticate_user!

  def create
    place = Place.find(params[:place_id])
    current_user.addfav(place)
    flash[:success] = "登録完了しました！"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    place = Place.find(params[:place_id])
    current_user.removefav(place)
    flash[:success] = "登録解除しました！"
    redirect_back(fallback_location: root_path)
  end
end

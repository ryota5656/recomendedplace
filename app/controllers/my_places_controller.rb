class MyPlacesController < ApplicationController
  before_action :authenticate_user!


  def todo
    @user = current_user.id
    @placesall = Place.all
    @places = Place.where(user_id: @user)
    @places_count = @places.count
    @places_lat = Place.select(:latitude).first
    @places_long = Place.select(:longitude).first
    @favorites = Favorite.where(user_id: @user)
    @completes = Complete.where(user_id: @user)
    @comp = Complete.new
  end

  def completes
    @user = current_user.id
    @completes = Complete.where(user_id: @user)
    @places = Place.where(user_id: @user)
  end

  def favorites
    @user = current_user.id
    @favorites = Favorite.where(user_id: @user)
    @complete = Complete.all
    @places = Place.where(user_id: @user)
  end

  def create
    @user = current_user.id
    @comp = Complete.new(params.permit(:rate,:comment,:place_id,:user_id))
      if @comp.save
        redirect_to my_places_todo_path
      else
        render my_places_todo_path
      end
  end

  def destroy

  end

  def edit
    @place = Complete.find(params[:id])
    session[:previous_url] = request.referer
  end

  def update
      @place = Complete.find(params[:id])
    if @place.update(place_params)
      redirect_to session[:previous_url], notice: "編集しました"
    else
      flash.now[:danger] = "編集に失敗しました"
      render 'edit'
    end
  end

  private
  def place_params
    params.require(:complete).permit(:comment,:rate)
  end


end

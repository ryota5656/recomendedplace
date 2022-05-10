class PlacesController < ApplicationController

  Dotenv.load

  def index
    @places = Place.all
    @places_lat = Place.select(:latitude).first
    @places_long = Place.select(:longitude).first
  end

  def home

    keyword = params[:search]
    keyword_lat = params[:search2]
    keyword_lng = params[:search3]
    keyword_cate = params[:category]
    keyword_rad = params[:radius]
    keyword_name = params[:name]

    if user_signed_in?
      @user = current_user.id
    else

    end

    @client = GooglePlaces::Client.new( ENV['GOOGLE_API_KEY'])

    @client2 = @client.spots( keyword_lat.to_f, keyword_lng.to_f,:language => 'ja',:name => keyword_name, :radius => keyword_rad,:types => keyword_cate, multipage: true,detail: true).sample(3)
  end

  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to my_places_todo_path, notice: "#{@place.name} の位置情報を保存しました" }
      else
        format.html { render :index, notice: "#{@place.name} の位置情報を保存できませんでした" }
      end
    end
  end

  def destroy
    @places = Place.find(params[:id])
    @places.destroy
    redirect_to my_places_todo_path
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:user_id, :name, :latitude, :longitude, :address, :price_level, :rating, :place_id)
    end

end

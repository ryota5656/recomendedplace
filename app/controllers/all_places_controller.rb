class AllPlacesController < ApplicationController
  def all
    @all_user = User.all

    if user_signed_in?
      @user = current_user.id
    else
    end

    @places = Complete.all
    @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])

    if params[:lat].present?
      @lat =  params[:lat]
    else
      @lat = 35.68944
    end

    if params[:lng].present?
      @lng = params[:lng]
    else
      @lng = 139.69167
    end
  end
end

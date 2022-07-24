require 'rails_helper'

RSpec.describe "GoogleApis", type: :request do



  before :each do
    @lat = '-33.8670522'
    @lng = '151.1957362'
    @radius = 500
    @pagetoken = 'CmRVAAAAqKK43TjXKnyEx4-XTWd4bC-iBq88Olspwga_JQbEpznYpfwXYbWBrxmb-1QYD4DMtq8gym5YruCEVjByOlKn8PWKQO5fHvuYD8rWKHUeBvMleM7k3oh9TUG8zqcyuhPmEhCG_C2XuypmkQ20hRvxro4sGhQN3nbWCjgpjyG_E_ayjVIoTGbViw'
    @place_id = 'ChIJN1t_tDeuEmsRUsoyG83frY4'
  end

  context 'List spots options', vcr: { cassette_name: 'list_spots_rankby_and_radius' } do
    after :each do
      @collection = GooglePlaces::Spot.list(@lat, @lng, ENV['GOOGLE_API_KEY'], :rankby => "prominence", :radius => @radius)
    end

    it 'should send radius and rankby options' do
      expect(GooglePlaces::Spot).to receive(:multi_pages_request).with(
        :spots,
        false,
        {
          location: "-33.86705220,151.19573620",
          radius: 500,
          rankby: "prominence",
          key: ENV['GOOGLE_API_KEY'],
          name: nil,
          language: nil,
          keyword: nil,
          retry_options: {}
        })
    end
  end


end

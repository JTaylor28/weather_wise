require 'rails_helper'

RSpec.describe MapquestService, type: :service do
  it 'can get lat and long from a city' do
    VCR.use_cassette('mapquest_service') do
      lat_long = MapquestService.new.get_lat_long('denver,co')
      expect(lat_long).to be_a(Hash)
      expect(lat_long[:results].first[:locations].first[:latLng].keys).to eq([:lat, :lng])
      expect(lat_long[:results].first[:locations].first[:latLng][:lat]).to be_a(Float)
      expect(lat_long[:results].first[:locations].first[:latLng][:lng]).to be_a(Float)
    end
  end
end
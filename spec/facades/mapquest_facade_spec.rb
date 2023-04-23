require "rails_helper"

RSpec.describe MapquestFacade, type: :facade do
  describe "find_coordinates" do
    it "Outputs coordinates when given a city and state" do
      VCR.use_cassette("mapquest_facade") do
        coordinates = MapquestFacade.new.find_coordinates("denver,co")
        expect(coordinates).to be_a(Hash)
        expect(coordinates[:results].first[:locations].first[:latLng].keys).to eq([:lat, :lng])
        expect(coordinates[:results].first[:locations].first[:latLng][:lat]).to be_a(Float)
        expect(coordinates[:results].first[:locations].first[:latLng][:lng]).to be_a(Float)
      end
    end
  end
end 
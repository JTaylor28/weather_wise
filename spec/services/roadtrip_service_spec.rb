require "rails_helper"

RSpec.describe RoadtripService do
  describe "get_directions" do
    it "can get travel time from an oragin and destination" do
      VCR.use_cassette("roadtrip_service") do
        results = RoadtripService.new.get_directions("denver, co", "pueblo, co")
        results = results[:route]
        expect(results).to be_a(Hash)
        expect(results).to have_key(:formattedTime)
        expect(results[:formattedTime]).to be_a(String)
      end
    end

    it "returns an error if the route is impossible" do
      VCR.use_cassette("roadtrip_service_impossible") do
        results = RoadtripService.new.get_directions("denver, co", "london, uk")
        info = results[:info]
        expect(info).to be_a(Hash)
        expect(info).to have_key(:statuscode)
        expect(info[:statuscode]).to eq(402)
      end
    end
  end
end
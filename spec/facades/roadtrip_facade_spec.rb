require "rails_helper"

RSpec.describe "Roadtrip Facade" do
  it "can get roadtrip info" do
    VCR.use_cassette("roadtrip_facade") do
      origin = "Denver,CO"
      destination = "Pueblo,CO"
      roadtrip = RoadtripFacade.get_roadtrip_info(origin, destination)
      expect(roadtrip).to be_a(Roadtrip)
      expect(roadtrip.start_city).to eq(origin)
      expect(roadtrip.end_city).to eq(destination)
      expect(roadtrip.travel_time).to be_a(String)
      expect(roadtrip.weather_at_eta).to be_a(Hash)
      expect(roadtrip.weather_at_eta.keys).to eq([:datetime, :temperature, :condition])
      expect(roadtrip.weather_at_eta[:datetime]).to be_a(String)
      expect(roadtrip.weather_at_eta[:temperature]).to be_a(Float)
      expect(roadtrip.weather_at_eta[:condition]).to be_a(String)
    end
  end

  it "can get roadtrip info for impossible routes" do
    VCR.use_cassette("roadtrip_facade_impossible") do
      origin = "Denver,CO"
      destination = "London,UK"
      roadtrip = RoadtripFacade.get_roadtrip_info(origin, destination)
      expect(roadtrip).to be_a(Roadtrip)
      expect(roadtrip.start_city).to eq(origin)
      expect(roadtrip.end_city).to eq(destination)
      expect(roadtrip.travel_time).to eq("impossible")
      expect(roadtrip.weather_at_eta).to eq({})
    end
  end
end
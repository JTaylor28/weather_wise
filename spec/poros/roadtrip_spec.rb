require "rails_helper"

RSpec.describe Roadtrip, type: :poro do
  describe "initialize" do
    it "exists with attributes" do
      weather_at_eta = {datetime: "2021-03-08 01:43:08", temperature: 44.2,  condition:"clear sky"}
      roadtrip = Roadtrip.new("Denver,CO", "Pueblo,CO", "01:43:08", weather_at_eta)

      expect(roadtrip).to be_a(Roadtrip)
      expect(roadtrip.start_city).to eq("Denver,CO")
      expect(roadtrip.end_city).to eq("Pueblo,CO")
      expect(roadtrip.travel_time).to eq("01:43:08")
      expect(roadtrip.weather_at_eta).to be_a(Hash)
      expect(roadtrip.weather_at_eta.keys).to eq([:datetime, :temperature, :condition])
      expect(roadtrip.weather_at_eta[:datetime]).to eq("2021-03-08 01:43:08")
      expect(roadtrip.weather_at_eta[:temperature]).to eq(44.2)
      expect(roadtrip.weather_at_eta[:condition]).to eq("clear sky")
    end
  end
end
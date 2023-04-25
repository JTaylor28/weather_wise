require "rails_helper"

RSpec.describe "Activity API" do
  describe " /api/v1/activity" do
    it "returns activity data" do
      VCR.use_cassette("activity_request") do
        get "/api/v0/activity?location=denver,co"

        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful
        expect(parsed).to be_a(Hash)
      end
    end
  end
end
require "rails_helper"

Rspec.describe "Salaries API" do
  describe "GET /api/v1/salaries" do
    it "can get salaries and forcast for a givin city" do
      VCR.use_cassette("salaries_request") do
        get "/api/v1/salaries?location=denver,co", headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }
      end
    end
  end
end
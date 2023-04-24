require "rails_helper"

RSpec.describe "Salaries API" do
  describe "GET /api/v1/salaries" do
    it "can get salaries and forcast for a givin city" do
      VCR.use_cassette("salaries_request") do
        get "/api/v0/salaries?location=denver,co", headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

        response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful
      end
    end
  end
end
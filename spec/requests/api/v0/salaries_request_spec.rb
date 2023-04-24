require "rails_helper"

RSpec.describe "Salaries API" do
  describe "GET /api/v1/salaries" do
    it "can get salaries and forcast for a givin city" do
      VCR.use_cassette("salaries_request") do
        get "/api/v0/salaries?location=denver"

        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful
        expect(parsed).to be_a(Hash)
        expect(parsed.keys).to eq([:data])
        expect(parsed[:data]).to be_a(Hash)
        expect(parsed[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
        expect(parsed[:data][:attributes][:destination]).to be_a(String)
        expect(parsed[:data][:attributes][:forecast]).to be_a(Hash)
        expect(parsed[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
        expect(parsed[:data][:attributes][:salaries]).to be_a(Array)
        expect(parsed[:data][:attributes][:salaries].first.keys).to eq([:title, :min, :max])
      end
    end
  end
end
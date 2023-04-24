require "rails_helper"

RSpec.describe SalariesFacade, type: :facade do
  describe "find_salaries_and_forcast" do
    it "finds salaries and forecast for a city" do
      VCR.use_cassette("salaries_facade") do
        city = "denver"
        state = "co"
        salaries = SalariesFacade.new(city, state).find_salaries_and_forecast
        expect(salaries).to be_a(Hash)
        expect(salaries.keys).to eq([:destination, :forecast, :salaries])
        expect(salaries[:destination]).to be_a(String)
        expect(salaries[:forecast]).to be_a(Hash)
        expect(salaries[:salaries]).to be_a(Array)
      end
    end
  end
end
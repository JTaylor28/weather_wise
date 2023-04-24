require "rails_helper"

RSpec.describe SalariesService, type: :service do
  describe "get_city_salaries" do
    it "can get salaries based on location" do
      VCR.use_cassette("salaries_service") do
        city = "denver"
        salaries = SalariesService.new.get_city_salaries(city)
        expect(salaries).to be_a(Hash)
        expect(salaries[:salaries]).to be_a(Array)
        expect(salaries[:salaries].first.keys).to eq([:job, :salary_percentiles])
        expect(salaries[:salaries].first[:job]).to be_a(Hash)
        expect(salaries[:salaries].first[:job].keys).to eq([:id, :title])
        expect(salaries[:salaries].first[:salary_percentiles]).to be_a(Hash)
        expect(salaries[:salaries].first[:salary_percentiles].keys).to eq([:percentile_25, :percentile_50, :percentile_75])
      end
    end
  end
end
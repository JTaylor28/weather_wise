require "rails_helper"

RSpec.describe SalariesFacade, type: :facade do
  describe "find_salaries_and_forcast" do
    VCR.use_cassette("salaries_facade") do
      city = "denver"
      salaries = SalariesFacade.new(city).find_salaries
      require 'pry'; binding.pry
    end
  end
end
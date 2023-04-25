require "rails_helper"

RSpec.describe ActivityService, type: :service do
  describe "get_activities" do
    it "returns activity data" do
      VCR.use_cassette("activity_service") do
        service = ActivityService.new
        activities = service.get_activities("education")

        expect(activities).to be_a(Hash)
        expect(activities).to have_key(:activity)
        expect(activities).to have_key(:type)
        expect(activities).to have_key(:participants)
        expect(activities).to have_key(:price)
        expect(activities).to have_key(:link)
        expect(activities).to have_key(:key)
      end
    end
  end
end
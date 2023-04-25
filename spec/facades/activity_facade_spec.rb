require "rails_helper"

RSpec.describe ActivityFacade, type: :facade do
  describe "find_activity" do
    it "returns an activity and a forecasr" do
      VCR.use_cassette("activity_facade") do
        location = "denver,co"
        activities = ActivityFacade.new(location).find_activity
        expect(activities).to be_a(Activity)
        expect(activities.destination).to be_a(Array)
        expect(activities.forecast).to be_a(Hash)
        expect(activities.activities).to be_a(Array)
      end
    end
  end
end
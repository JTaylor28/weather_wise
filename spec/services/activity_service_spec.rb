require "rails_helper"

RSpec.describe ActivityService, type: :service do
  describe "get_activities" do
    it "returns activity data" do
      VCR.use_cassette("activity_service") do
        service = ActivityService.new
        activities = service.get_activities("denver,co")
        activity = activities.first

        # expect(activities).to be_an(Array)
        # expect(activity).to have_key(:name)
        # expect(activity).to have_key(:description)
        # expect(activity).to have_key(:city)
        # expect(activity).to have_key(:state)
        # expect(activity).to have_key(:country)
        # expect(activity).to have_key(:activity_type)
        # expect(activity).to have_key(:cost)
        # expect(activity).to have_key(:duration)
        # expect(activity).to have_key(:image_url)
      end
    end
  end
end
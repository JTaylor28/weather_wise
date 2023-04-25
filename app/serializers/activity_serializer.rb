class ActivitySerializer
  def self.format_resource(resource)
    {
      data: {
        id: 'null',
        type: 'activities',
        attributes: {
          destination: resource[:destination],
          forecast: {
            summary: resource[:forecast][:summary],
            temperature: resource[:forecast][:temperature]
          },
          activities: format_activities(resource[:activities])
        }
      }
    }
  end

  def self.format_activities(activity)
    activity.map do |a|
      
     a.activity = {
      type: s.type,
      participants: s.participants,
      price: s.price
      }
    end
  end
end


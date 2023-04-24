class SalariesSerializer
  def self.format_resource(resource)
    {
      data: {
        id: 'null',
        type: 'salaries',
        attributes: {
          destination: resource[:destination],
          forecast: {
            summary: resource[:forecast][:summary],
            temperature: resource[:forecast][:temperature]
          },
          salaries: format_salaries(resource[:salaries])
        }
      }
    }
  end

  def self.format_salaries(salary)
    salary.map do |s|
      {
        title: s.title,
        min: s.min,
        max: s.max
      }
    end
  end
end
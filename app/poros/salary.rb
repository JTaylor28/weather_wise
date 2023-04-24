class Salary 
  attr_reader :id, 
              :type,
              :title, 
              :min, 
              :max
  def initialize(title, min, max)
    @id = nil
    @type = "salary"
    @title = title
    @min = min
    @max = max
  end
end
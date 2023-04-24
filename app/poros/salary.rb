class Salary 
  attr_accessor :id, 
              :type,
              :title, 
              :min, 
              :max
              
  def initialize(title, min, max)
    @title = title
    @min = min
    @max = max
  end
end
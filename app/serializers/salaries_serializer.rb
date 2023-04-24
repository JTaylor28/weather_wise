class SalariesSerializer
  include FastJsonapi::ObjectSerializer
  
  set_id :id
  set_type :salary
  attributes :destination, :forcast, :salaries
end
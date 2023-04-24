require "rails_helper"

RSpec.describe Salary, type: :poro do
  describe "intialize" do
    it "exists" do
      title = "Account Manager"
      min = "52755.545248860515"
      max = "82696.16391306919"
      expect(Salary.new(title, min, max)).to be_a(Salary)
    end

    it "has attributes" do
      title = "Account Manager"
      min = "52755.545248860515"
      max = "82696.16391306919"
      salary = Salary.new(title, min, max)
      expect(salary.id).to eq(nil)
      expect(salary.type).to eq("salary")
      expect(salary.title).to eq(title)
      expect(salary.min).to eq(min)
      expect(salary.max).to eq(max)
    end
  end
end
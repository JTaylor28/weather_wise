require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end

  it "can create a user" do
    guy = User.create(email: "email@email.com", password: "awesomepassword", password_confirmation: "awesomepassword")
    expect(guy).to have_attribute(:email) 
    expect(guy).to_not have_attribute(:password)
    expect(guy.password_digest).to_not eq("ImmaWizard!")
  end
end
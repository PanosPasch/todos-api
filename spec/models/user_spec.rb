require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with email and password" do
    user = User.new(email: "a@b.com", password: "Password1!", password_confirmation: "Password1!")
    expect(user).to be_valid
  end

  it "is invalid without email" do
    user = User.new(password: "Password1!", password_confirmation: "Password1!")
    expect(user).not_to be_valid
  end

  it "enforces unique email (case-insensitive)" do
    User.create!(email: "Me@Example.com", password: "Password1!", password_confirmation: "Password1!")
    u2 = User.new(email: "me@example.com", password: "Password1!", password_confirmation: "Password1!")
    expect(u2).not_to be_valid
  end
end

require 'rails_helper'

RSpec.describe "UserRegistrations", type: :request do
  describe "POST /users" do
    let(:valid_user_params) do
      {
        user: {
          name: "Test User",
          email: "test@example.com",
          password: "password",
          password_confirmation: "password",
          profile_image: fixture_file_upload(Rails.root.join('spec/fixtures/profile_image.jpg'), 'image/jpg')
        }
      }
    end

    it "registers a new user with a profile image" do
      expect {
        post users_path, params: valid_user_params
      }.to change(User, :count).by(1)

      user = User.last
      expect(user.profile_image).to be_attached
      expect(user.name).to eq("Test User")
      expect(user.email).to eq("test@example.com")
    end
  end
end

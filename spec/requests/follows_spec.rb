require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let(:user) { FactoryBot.create(:user) }
  before { sign_in user }
  let!(:test_user) { FactoryBot.create(:user) }
  before { get "/follow_user?nickname=#{test_user.nickname}" }

  describe "GET /follow" do
    it "user can follow another user" do
      get user_profile_path(user)
      expect(response.body).to include(test_user.nickname)
    end
  end

  describe "GET /unfollow" do
    it "user see notification when unfollow another user and did not see him in his subscriptions" do
      get "/unfollow_user?nickname=#{test_user.nickname}"
      get user_profile_path(user)
      expect(flash[:notice]).to match("You have successfully unfollow #{test_user.nickname}")
      get user_profile_path(user)
      expect(response.body).not_to include(test_user.nickname)
    end
  end
end

require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  before { sign_in user }
  let!(:posts) { FactoryBot.create_list(:post, 3, user: user) }
  let(:test_user) { FactoryBot.create(:user) }
  let!(:test_posts) { FactoryBot.create_list(:post, 3, user: test_user) }

  describe "GET /user_posts/:user_id" do
    subject { get user_posts_path(test_user) }

    it "shows users post on his page" do
      subject
      test_posts.each do |p|
        expect(response.body).to include(p.content)
      end
    end

    it "do not show posts of another user on his page" do
      subject
      posts.each do |p|
        expect(response.body).not_to include(p.content)
      end
    end
  end

  describe "GET /profile/:user_id" do
    it "shows users posts in his profile page" do
      get user_profile_path(user)
      posts.each do |p|
        expect(response.body).to include(p.content)
      end
    end

    it "do not show another user profile" do
      get user_profile_path(test_user)
      expect(response).to redirect_to("/")
      # expect(response).to have_http_status(:unprocessable_entity)
      expect(flash[:alert]).to match("You are not authorized to perform this action.")
    end
  end

  describe "GET /feed" do
    it "show current user feed(subscriptions)" do
      user.follow(test_user.id)
      get user_feed_path
      test_posts.each do |p|
        expect(response.body).to include(p.content)
      end
    end

    it "posts of a user who is not subscribed to are not shown" do
      get user_feed_path
      test_posts.each do |p|
        expect(response.body).not_to include(p.content)
      end
    end
  end
end

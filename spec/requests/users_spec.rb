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

  describe "GET /profile" do
    it "shows users posts in his profile page" do
      get user_profile_path(user)
      posts.each do |p|
        expect(response.body).to include(p.content)
      end
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

  describe "GET /users/edit" do
    subject { get edit_user_registration_path(user) }

    it "renders a successful response" do
      subject
      expect(response).to be_successful
    end

    it "renders the correct form of a post" do
      subject
      expect(response.body).to include("Name", "Surname", "Update", "Password")
    end

    it "renders the correct data to edit of a post" do
      subject
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.email)
    end
  end
end

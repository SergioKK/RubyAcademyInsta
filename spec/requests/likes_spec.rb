require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let!(:test_user) { FactoryBot.create(:user) }
  before { sign_in test_user }

  let!(:test_post) { FactoryBot.create(:post) }
  let!(:like_attributes) { FactoryBot.attributes_for(:like, user_id: test_user.id, post_id: test_post.id) }

  describe "POST /likes" do
    it "creates a new like on a post" do
      expect { post likes_path, params: { like: like_attributes } }.to change(Like, :count).by(1)
    end
  end

  describe "DELETE /destroy" do
    let!(:test_like) { FactoryBot.create(:like) }
    it "destroys the like" do
      expect { delete like_path(test_like) }.to change(Like, :count).by(0)
    end
  end
end

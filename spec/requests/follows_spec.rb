require 'rails_helper'

RSpec.describe "Follows", type: :request do
  describe "GET /follow" do
    it "returns http success" do
      get "/follows/follow"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /unfollow" do
    it "returns http success" do
      get "/follows/unfollow"
      expect(response).to have_http_status(:success)
    end
  end

end

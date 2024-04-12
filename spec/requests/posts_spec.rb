require 'rails_helper'

RSpec.describe "/posts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  before { sign_in user }
  let!(:test_post) { FactoryBot.create(:post, user: user) }
  let!(:post_attributes) { FactoryBot.attributes_for(:post, user: user) }

  describe "GET /posts" do
    subject { get posts_path }

    it "renders a successful response" do
      subject
      expect(response).to be_successful
    end

    it "renders the correct content" do
      subject
      expect(response.body).to include(test_post.content)
    end
  end

  describe "GET /posts/:id" do
    subject { get post_path(test_post) }

    it "renders a successful response" do
      subject
      expect(response).to be_successful
    end

    it "renders the correct content of a post" do
      subject
      expect(response.body).to include(test_post.content)
    end
  end

  describe "GET /posts/new" do
    subject { get new_post_path }

    it "renders a successful response" do
      subject
      expect(response).to be_successful
    end

    it "renders the correct form of a post" do
      subject
      expect(response.body).to include("Title", "Content", "Create Post")
    end
  end

  describe "GET  /posts/:id/edit" do
    subject { get edit_post_path(test_post) }

    it "renders a successful response" do
      subject
      expect(response).to be_successful
    end

    it "renders the correct form of a post" do
      subject
      expect(response.body).to include("Title", "Content", "Update Post")
    end

    it "renders the correct data to edit of a post" do
      subject
      expect(response.body).to include(test_post.title)
      expect(response.body).to include(test_post.content)
    end
  end

  describe "POST /posts" do
    context "with valid parameters" do

      it "creates a new Post" do
        expect {
          post posts_path, params: { post: post_attributes }
        }.to change(Post, :count).by(1)
      end

      it "redirects to the created post" do
        post posts_path, params: { post: post_attributes }
        expect(response).to redirect_to(post_path(Post.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Post" do
        expect {
          post posts_path, params: { post: FactoryBot.attributes_for(:post, title: nil) }
        }.to change(Post, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post posts_path, params: { post: FactoryBot.attributes_for(:post, image: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "redirects to the post" do
        patch post_path(test_post), params: { post: FactoryBot.attributes_for(:post) }
        test_post.reload
        expect(response).to redirect_to(post_path(test_post))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch post_path(test_post), params: { post: FactoryBot.attributes_for(:post, title: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("1 error prohibited this post from being saved")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested post" do
      expect { delete post_path(test_post) }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete post_path(test_post)
      expect(response).to redirect_to(posts_path)
    end
  end
end

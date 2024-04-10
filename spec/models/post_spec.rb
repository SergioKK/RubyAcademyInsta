require 'rails_helper'
require "#{Rails.root}/spec/helpers/image_helper_spec.rb"

RSpec.describe Post, type: :model do
  subject { FactoryBot.create(:post) }

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:comments).class_name('Comment') }
    it { should have_many(:likes).class_name('Like') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'image' do
    let(:image) { post.image_data }
    let(:post) { FactoryBot.create(:post) }
    it "extracts metadata" do
      expect(JSON.parse(image)['metadata']['mime_type']).to eq("image/jpeg")
      expect(JSON.parse(image)['metadata']['size']).to be_instance_of(Integer)
    end
  end

  describe 'scopes' do
    describe '.followers' do
      let(:user_1) { FactoryBot.create(:user) }
      let(:posts) { Post.followers(user_1.following) }
      before { user_1.follow(subject.user.id) }
      it 'returns only followers posts' do
        expect(posts.first['title']).to eq(subject.title)
        expect(posts.first['content']).to eq(subject.content)
      end

      it 'does not returns posts of unfollowed user' do
        user_1.unfollow(subject.user.id)
        expect(posts.first).to be(nil)
      end
    end
  end
end

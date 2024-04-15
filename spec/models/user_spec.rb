require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }

  describe 'associations' do
    it { should have_many(:posts).class_name('Post') }
    it { should have_many(:comments).class_name('Comment') }
    it { should have_many(:likes).class_name('Like') }

    it { should have_many(:follower_relationships).with_foreign_key(:following_id).class_name('Follow') }
    it { should have_many(:followers).through(:follower_relationships).source(:follower) }

    it { should have_many(:following_relationships).with_foreign_key(:follower_id).class_name('Follow') }
    it { should have_many(:following).through(:following_relationships).source(:following) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:nickname) }
    it { should validate_uniqueness_of(:nickname) }
    it { should have_many :posts }
    it { should_not allow_value(nil).for(:name) }
  end

  describe 'can follow/unfollow another user' do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }
    before { user_1.follow(user_2.id) }
    it 'follows another user' do
      expect(user_2.followers.count).to eq(1)
    end
    it 'unfollows another user' do
      user_1.unfollow(user_2.id)
      expect(user_2.followers.count).to eq(0)
    end
  end
end

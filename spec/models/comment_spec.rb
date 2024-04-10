require 'rails_helper'

RSpec.describe Comment, type: :model do
  # subject { FactoryBot.create(:post) }

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
  end

  describe 'validations' do
    it { should validate_presence_of(:text) }
  end
end

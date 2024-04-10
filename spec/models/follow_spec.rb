require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'associations' do
    it { should belong_to(:follower).with_foreign_key(:follower_id).class_name('User') }
    it { should belong_to(:following).with_foreign_key(:following_id).class_name('User') }
  end
end

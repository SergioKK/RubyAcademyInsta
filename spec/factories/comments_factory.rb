FactoryBot.define do
  factory :comment do
    text { FFaker::Lorem.sentence }
    user_id { FactoryBot.create(:user).id }
    post_id { FactoryBot.create(:post).id }
  end
end

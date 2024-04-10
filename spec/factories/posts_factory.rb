require "#{Rails.root}/spec/helpers/image_helper_spec.rb"

FactoryBot.define do
  factory :post do
    title { FFaker::Lorem.word }
    content { FFaker::Lorem.paragraph }
    image_data { TestData.image_data }
    user { FactoryBot.create(:user) }
  end
end

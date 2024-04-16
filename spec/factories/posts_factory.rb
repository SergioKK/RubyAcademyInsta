require "#{Rails.root}/spec/support/image.rb"

FactoryBot.define do
  factory :post do
    title { FFaker::Lorem.word }
    content { FFaker::Lorem.paragraph }
    image { TestData.image_data }
    user { FactoryBot.create(:user) }
  end
end

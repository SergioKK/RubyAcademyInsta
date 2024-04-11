require "#{Rails.root}/spec/helpers/image_helper_spec.rb"

FactoryBot.define do
  factory :post do
    cached_file = Shrine.upload(File.open("spec/files/image.jpeg"), :cache)
    cached_file.metadata["mime_type"] = "image/jpeg"
    image_json = cached_file.to_json

    title { FFaker::Lorem.word }
    content { FFaker::Lorem.paragraph }
    # image { image_json }
    image { TestData.image_data }
    user { FactoryBot.create(:user) }
  end
end

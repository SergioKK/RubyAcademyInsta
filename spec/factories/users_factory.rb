FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    surname { FFaker::Name.last_name }
    nickname { FFaker::Name.unique.first_name }
    email { FFaker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

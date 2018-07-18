FactoryBot.define do
  factory :category do
    lang { { en: Faker::Commerce.department(1), ua: Faker::Commerce.department(3) } }
    image { Faker::Avatar.image }
  end
end

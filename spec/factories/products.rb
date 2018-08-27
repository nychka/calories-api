FactoryBot.define do
  factory :product do
    lang { { en: Faker::Food.ingredient } }
    image { Faker::Avatar.image }
    nutrition { { calories: Faker::Number.between(100, 300) }}
    category_id { rand(1..10) }
  end
end

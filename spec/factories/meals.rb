FactoryBot.define do
  factory :meal do
    product
    user
    weight {Random.rand(1000)}
  end
end

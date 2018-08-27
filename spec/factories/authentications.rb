FactoryBot.define do
  factory :authentication do
    provider { %w(facebook google).sample }
    access_token { SecureRandom.urlsafe_base64(64, false) }
    email { Faker::Internet.email }
    user
  end
end

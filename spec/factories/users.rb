FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }

    transient do
      with_auth false
    end

    after :create do |user, options|
      create(:authentication, user: user) if options.with_auth
    end
  end
end

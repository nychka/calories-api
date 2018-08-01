ruby '2.5.0'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.2.0'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'devise'
gem 'factory_bot_rails'
gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
gem 'scout_apm'
gem 'simple_token_authentication', '~> 1.0'
gem 'active_model_serializers'
gem 'rack-cors'
gem 'kaminari'
gem 'bootsnap'
gem 'faraday'


group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.7'
  gem 'database_cleaner'
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

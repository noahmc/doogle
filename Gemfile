source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '4.2.5.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'capybara'
gem 'rails_admin'
gem 'devise'

gem 'heroku_san'
gem 'nokogiri'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'sdoc', '~> 0.4.0', group: :doc

group :test do
  gem 'webmock'
  gem "capybara-webkit"
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development, :test do
  gem 'sqlite3'
  gem 'byebug',      '3.4.0'
  gem 'web-console', '2.0.0.beta3'
  gem 'spring',      '1.1.3'
  gem "rspec-rails"
end

group :production do
  gem 'pg'
  gem 'rails_12factor', '0.0.2'
end
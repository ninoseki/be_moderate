source 'https://rubygems.org'
ruby '~> 2.5'

gem 'dalli'
gem 'dotenv'
gem 'rest-client'
gem 'rollbar'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'washbullet'

group :test, :development do
  gem 'rake'
end

group :test do
  gem 'coveralls', require: false
  gem 'mocha'
  gem "rack-test"
  gem "rspec"
  gem "vcr"
  gem 'webmock'
end

group :development do
  gem 'foreman'
  gem 'travis'
end

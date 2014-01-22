source 'http://rubygems.org'

gem 'rails', '~> 3.2.12'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

platforms :ruby do
  gem 'pg', '>= 0.9.0'
  gem 'therubyracer'
  gem 'unicorn'
  gem 'kgio'
end

gem 'haml-rails'
gem 'jquery-rails'
gem 'will_paginate', '~> 3.0.4'
gem "audited-activerecord", "~> 3.0.0.rc2"
gem 'inherited_resources'
gem 'devise'
gem "devise-encryptable"
gem 'rabl'
gem 'state_machine'

gem 'acts_as_list'
gem 'dynamic_form'

group :development do
  gem 'debugger', :platform => :mri_19
  #gem 'RedCloth', '>= 4.1.1'
end

group :development, :test do
  gem 'sqlite3'
  gem "rspec-rails"
  gem 'RedCloth', '>= 4.1.1'
end

group :test do
  gem "factory_girl_rails", "~> 4.0"

  gem "cucumber-rails", :require => false
  gem 'mocha', :require => false
  gem 'webrat'
  gem 'database_cleaner'
end

# Use Capistrano for deployment
gem 'capistrano', '~> 2', group: :development
gem 'simpleidn'
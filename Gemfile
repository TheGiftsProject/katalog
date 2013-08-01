source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'slim'
gem 'pg'
gem 'textacular', '~> 3.0', require: 'textacular/rails'
gem 'bootstrap-sass'
gem 'enumify'
gem 'controller_support'
gem 'haml'
gem 'omniauth'
gem 'omniauth-github'
gem 'octokit' # Simple Ruby wrapper for the GitHub API

gem 'hogan_assets'

# compass-rails is kinda dead and doesn't work on Rails4, use this until there's a proper fix.
gem 'compass-rails', github: 'milgner/compass-rails', ref: '1749c06f15dc4b058427e7969810457213647fb8'
gem 'animation'
gem 's3_direct_upload'
gem 'font-awesome-rails'
gem 'twitter-typeahead-rails'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'debugger'
  gem 'awesome_print'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'spork-rails', :github => 'sporkrb/spork-rails'
  gem 'guard-spork', :github => 'guard/guard-spork'
  gem 'rb-fsevent', '~> 0.9'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'powder'
  gem 'quiet_assets'
end
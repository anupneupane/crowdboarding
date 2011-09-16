source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'devise'
gem 'cancan'
gem 'jquery-rails'
gem 'haml'
gem 'formtastic'
gem "compass", :git => 'git://github.com/chriseppstein/compass.git', :branch => 'rails31'
gem 'compass-960-plugin'
gem 'typus'
gem 'ancestry'
gem 'geocoder'
gem 'aws-s3'
gem "paperclip"
gem 'barometer'
gem 'acts-as-taggable-on'
gem 'rails3-jquery-autocomplete'
gem 'omniauth', '>= 0.2.6'
gem 'twitter'
gem 'kaminari'
gem "friendly_id", "~> 4.0.0.beta12"

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'hpricot'
  gem 'capybara'
  gem 'launchy'
  gem 'cucumber-rails'
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'mongrel', '1.2.0.pre2'
  gem 'thin'
  gem 'sqlite3'
  # gem 'pg'
  gem 'ruby-debug19'
  # Guard gems
  # gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-sass'
  gem 'guard-bundler'
  gem 'growl'
  # gem 'guard-mozrepl'
  gem 'guard-livereload'
  # Pretty printed test output
  gem 'turn', :require => false
  # Data generators
  gem 'populator'
  gem 'faker'
end
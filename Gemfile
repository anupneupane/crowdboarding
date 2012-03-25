source 'http://rubygems.org'

gem 'rails', '3.2.2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier'
  
  gem 'compass-rails', :ref => '9d88ed1690dec0215674c8de31206e76d334dcb6' #:git => 'git://github.com/Compass/compass-rails.git'
  gem 'compass-960-plugin'
end

gem 'devise'
gem 'cancan'
gem 'jquery-rails'
gem 'haml'
gem 'formtastic'
gem 'typus', :git => 'git://github.com/fesplugas/typus.git', :branch => 'master'
gem 'ancestry'
gem 'geocoder'
gem 'aws-sdk'
gem 'aws-s3'
gem "paperclip"
gem 'barometer'
gem 'acts-as-taggable-on'
gem 'rails3-jquery-autocomplete'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
# gem 'twitter'
gem 'kaminari'
gem "friendly_id"

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
  # gem 'thin'
  gem 'sqlite3'
  # gem 'pg'
  gem 'ruby-debug19'
  # Guard gems
  # gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard'
  gem 'guard-rspec'
  # gem 'guard-mozrepl'
  gem 'guard-livereload'
  # Pretty printed test output
  gem 'turn', :require => false
  # Data generators
  gem 'populator'
  gem 'faker'
end
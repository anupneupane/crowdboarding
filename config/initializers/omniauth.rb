Rails.application.config.middleware.use OmniAuth::Builder do
  # you need a store for OpenID; (if you deploy on heroku you need Filesystem.new('./tmp') instead of Filesystem.new('/tmp'))
  # require 'openid/store/filesystem'
  
  provider :twitter, 'vrScGb9FJH9tk57n9Xtag', 'lQCz1gyIKwtntRqgqOiEx4vJEcls5tWrN11kIvvj0'
  provider :facebook, '224901847535829', 'a992b5a9f55f854fd0d012ca8d2c39d9'
  
  # provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end
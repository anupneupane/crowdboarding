class Event < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  validates :name, :presence => true, :length => { :maximum => 100 }
  validates :contact_details, :length => { :maximum => 100 }
  validates :city_id, :presence => true
  validates :starts_at, :presence => true
  validates :street, :presence => true
  validates :country_id, :presence => true
  validate :maximum_tags
  
  geocoded_by :address, :latitude  => :lat, :longitude => :lng 
  after_validation :geocode, :if => :street_changed? 
  
  acts_as_taggable
  
  attr_accessible :name, :description, :street, :lat, :lng, :contact_details, :tag_tokens, :country_id, :city_id
  
  belongs_to :user
  belongs_to :city
  belongs_to :country
  has_many :users
  has_many :attendances
  has_many :attenders, :through => :attendances, :source => :user
  has_many :comments, :as => :commentable
  
  attr_reader :tag_tokens
  
  after_create :notify_friends
  after_create :send_tweet
  
  geocoded_by :address, :latitude => :lat, :longitude => :lng
  after_validation :geocode, :if => :change_address?
  
  scope :recent, :order => "starts_at DESC"
  scope :from_now, :order => "starts_at ASC", :conditions => ["starts_at > ?", Time.now - 2.hour]
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
  
  def address
    [street, city.try(:name), country.try(:name)].compact.join(', ')
  end
  
  def size_status
    case users_count
    when 0..10 then "small meeting"
    when 11..20 then "medium small meeting"
    else 
      "big meeting"
    end
  end
  
  def weather
    begin
      barometer = Barometer.new("#{self.city.name}, #{self.country.name}")
      weather = Barometer::Weather.new
      # If internet connection is down or it takes to long.
      Timeout::timeout(3) do
        weather = barometer.measure
      end
      forecast = weather.for(self.starts_at)
    rescue ArgumentError 
      forecast = nil
    rescue SocketError
      forcast = nil
    rescue Timeout::Error
      forcast = nil
    rescue EOFError
      forcast = nil
    end

    if forecast.nil?
      return {:high => 'n/a', :icon => 'unknown'}
    else
      icon = if ['nt_flurries','nt_rain','nt_sleet', 'nt_snow','nt_tstorms','chancerain','chancetstorms'].include? forecast.icon
        'rain'
      else #!clear !mostlysunny !partlysunny !sunny partlycloudy
        forecast.icon
      end

      return {:high => forecast.high.c, :icon => icon}     
    end
  end
  
  def tag_tokens=(tags)
    if tags.present?
      @tag_tokens = tags.squeeze(" ")
    else
      @tag_tokens = nil
    end
    self.tag_list = @tag_tokens.try(:split, /(\s|,|,\s|\s,|\s,\s)/) if @tag_tokens.present?
  end
  
  def send_tweet
    if Rails.env == 'production'
      if self.country.name.downcase == 'spain'
        configure_twitter "ES"
        Twitter.update("Nuevo evento en #{self.city.name}, #{self.country.name} http://www.crowdboarding.com/events/#{self.id}")
      else
        configure_twitter "EN"
        Twitter.update("New event in #{self.city.name}, #{self.country.name} http://www.crowdboarding.com/events/#{self.id}")
      end
    end
  end
  
  def days_left
    ((self.starts_at - Time.now)/1.day).round()
  end
  

  # Class methods
  
  class << self
  
    def search(params)
      tire.search do
        query { string params[:query], default_operator: "AND" } if params[:query].present?
        filter :range, :starts_at: { lte: Time.zone.now } if params[:query].present?
        sort { by :starts_at, "desc" }
      end
    end

  end

  
  private
    def minimum_tags
      self.errors.add(:tag_tokens, "we need at least 1 tag") if self.tag_list.length < 1
    end
    
    def maximum_tags
      self.errors.add(:tag_tokens, "maximal 20 tags allowed") if self.tag_list.length > 20
    end
    
    def find_or_create_city
      city = City.find_or_create_by_name_and_country_id(self.city.name, self.country_id)
      self.city = city
      true
    end
    
    # Send notifications my friends and to people me as friend
    def notify_friends
      # Create notifications to the users friends
      self.user.friends.each do |friend|
        friend.notifications.create!(:body => I18n.translate('notification.types.event_created'))
      end
      # Create notifications to the users who have this user as a friend
      self.user.inverse_friends.each do |friend|
        friend.notifications.create!(:body => I18n.translate('notification.types.event_created'))
      end
    end
    
    def configure_twitter(language = "EN")
      Twitter.configure do |config|
        config.consumer_key = ENV["TW_#{language}_CONSUMER_KEY"]
        config.consumer_secret = ENV["TW_#{language}_CONSUMER_SECRET"]
        config.oauth_token = ENV["TW_#{language}_OAUTH_TOKEN"]
        config.oauth_token_secret = ENV["TW_#{language}_OAUTH_TOKEN_SECRET"]
      end
    end
    
    def change_address?
      street_changed? || city_id_changed?
    end
end
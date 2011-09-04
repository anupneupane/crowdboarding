class HomeController < ApplicationController
  def index
    @stored_city = false
    @current_location = if current_user.blank? or current_user.default_city.blank?
      "#{request.location.city}, #{request.location.country}"
      unless @current_location.present?
        'Madrid, Spain'
      end
    else
      @stored_city = true
      "#{current_user.default_city.name.camelize}, #{current_user.default_city.country.name.camelize}"
    end
    
    @events = Event.from_now.recent.near(@current_location).page(params[:page]).per(10)
    
    @events_from_now = Event.from_now.limit(5)
    @active_users = User.limit(10)
    @tags = Event.tag_counts_on(:tags)
  end
end
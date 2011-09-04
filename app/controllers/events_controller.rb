class EventsController < ApplicationController
  load_and_authorize_resource
  autocomplete :city, :name, :full => false, :display_value => :capitalize_name
  
  # GET /events
  # GET /events.xml
  def index
      conditions = []
      conditions << Event.escape_sql(["country_id = ?", params[:country_id]]) if params[:country_id].present?
      conditions << Event.escape_sql(["LOWER(city_name) LIKE LOWER(?)", "%#{params[:city_name].downcase}%"]) if params[:city_name].present?
      
      @events = Event.where(conditions.join(" AND ")).page(params[:page]).per(10)
      # @events = Event.joins(:taggings, :tags).where(["events.name LIKE ? OR events.city_name LIKE ? ", search_string, search_string]).page(params[:page]).per(10)
      # @events = Event.recent.page(params[:page]).per(10)
      # @events = Event.page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events }
    end
  end
  
  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])
    @event.increment!(:views_count)
    @attendance = current_user.attendance(@event) if current_user
    # @gmaps_json = @event.to_gmaps4rails
    @attenders = @event.attenders
    @weather = @event.weather
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @event }
    end
  end

  
  # GET /events/new
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  def create
    if params[:event] && params[:event][:starts_at].match(/^(\d{4})(\/|-)(\d{2})(\/|-)(\d{2})/)
      datetime_starts_at = Time.new($1, $3, $5, params[:event]["starts_at(4i)"], params[:event]["starts_at(5i)"] )
      params[:event]["starts_at(4i)"] = nil
      params[:event]["starts_at(5i)"] = nil
      params[:event][:starts_at] = nil
    end
  
    # City 
    city = City.find_or_create_by_name_and_country_id(params[:event][:city], params[:event][:country_id])
    params[:event][:city_id] = city.id
    params[:event].delete :city
  
    @event = current_user.events.new(params[:event])
    @event.starts_at = datetime_starts_at
    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
      else
        flash[:error] = 'An error occured'
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /events/1
  def update
    if params[:event] && params[:event][:starts_at].match(/^(\d{4})(\/|-)(\d{2})(\/|-)(\d{2})/)
      datetime_starts_at = Time.new($1, $3, $5, params[:event]["starts_at(4i)"], params[:event]["starts_at(5i)"] )
      params[:event]["starts_at(4i)"] = nil
      params[:event]["starts_at(5i)"] = nil
      params[:event][:starts_at] = nil
    end
    
    # City
    city = City.find_or_create_by_name_and_country_id(params[:event][:city], params[:event][:country_id])
    params[:event][:city_id] = city.id
    params[:event].delete :city
    
    @event = current_user.events.find(params[:id])
    @event.starts_at = datetime_starts_at
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /events/1
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
    end
  end
end
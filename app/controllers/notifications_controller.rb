class NotificationsController < ApplicationController
  load_and_authorize_resource
  
  # GET /notifications
  def index
    @notifications = current_user.notifications.order("created_at DESC").page(params[:page]).per(10)
    if @notifications.present?
      Notification.update_all({:read => true}, "id IN (#{@notifications.map(&:id).join(", ")})")
    end
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to(notifications_url) }
    end
  end
end
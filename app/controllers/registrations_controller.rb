class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  private

    def build_resource(*args)
      super
      @user.ip_address = request.remote_ip
      if session[:omniauth]
        @user.apply_omniauth(session[:omniauth])
        @user.valid?
      end
    end
    
  protected

    def after_sign_up_path_for(resource)
      welcome_path
    end
end
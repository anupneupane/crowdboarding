class UsersController < ApplicationController
  load_and_authorize_resource
  # GET /users
  def index
    @users = User.page(params[:page]).per(10)
  end
  
  # GET /users/1
  def show
    @user = User.find(params[:id])
    @friends = @user.friends.limit(20)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Successfully updated') }
      else
        format.html { render :action => "edit" }
      end
    end
    
  end
end
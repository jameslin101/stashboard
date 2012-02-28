class ServicesController < ApplicationController

  before_filter :authorize, only: [:new, :crete, :edit, :update, :delete]
  before_filter :require_login, only: [:edit, :update, :delete]

  def index
    @title = "Services Home"
  end
  
  def new
    @title = "New Service"
    @service = Service.new(params[:id])
  end

  def show
    @title = "List of Statuses"
    @service = Service.find(params[:id])
  end
  
  def create
    @service = Service.new(params[:service])
    @service.user_id = current_user.id
    
    if @service.save
      flash[:notice] = "New service " + @service.name + " created."
      redirect_to services_path
    else
      flash[:error] = ap(@service.errors.full_messages)
      render :action => "new"
    end
  end

  def edit
    @title = "Edit Service"
    @service = Service.find(params[:id])
  end
  
  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      flash[:notice] = @service.name + " service updated."
      redirect_to services_path
    else
      flash[:error] = ap(@service.errors.full_messages)
      render :action => "edit"
    end
  end 
  
  def destroy 
    @service = Service.find(params[:id])
    if destroyed_service = @service.destroy
      flash[:notice] = destroyed_service.name.to_s + " service destroyed."
    else
      flash[:error] = "Error destroying "+ @service.name + " service."
    end
    redirect_to services_path
  end
  private
  
  def is_admin?
    service = Service.find(params[:id])
    service.user == current_user
  end
  
  def require_login
    unless is_admin?
      flash[:error] = "You must be the admin user to access this section."
      redirect_to services_path
    end
  end
end

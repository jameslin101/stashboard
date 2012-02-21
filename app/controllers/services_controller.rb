class ServicesController < ApplicationController

  #before_filter :authorize
  
  before_filter :is_admin?, only: [:update,:edit,:delete]

  def index
    @title = "Services Home"
  end
  
  def new
    @service = Service.new(params[:id])
  end

  def show
    @title = "Services Home"
    @service = Service.find(params[:id])
  end
  
  def create
    puts params

    @service = Service.new(params[:service])
    if signed_in?
      @service.user_id = current_user.id
    end
    
    if @service.save
      flash[:notice] = "New service created."
      redirect_to services_path
    else
      flash[:error] = ap(@service.errors.full_messages)
      redirect_to new_service_path
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    puts params

    @service = Service.find(params[:id])
    #@service.user_id = current_user.id
    if @service.update_attributes(params[:service])
      flash[:notice] = @service.name + " service updated."
    else
      flash[:error] = "Error updating " + @service.name + " service."
    end
    redirect_to services_path
  end 
  
  def destroy 
    @service = Service.find(params[:id])
    ap @service
    if @service.destroy
      flash[:notice] = "Service destoryed."
    else
      flash[:error] = "Error destroying service."
    end
    redirect_to services_path
  end
  private
  
  def is_admin?
    service = Service.find(params[:id])
    service.user == current_user
  end
end

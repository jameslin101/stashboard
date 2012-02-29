class StatusesController < ApplicationController

  before_filter :authorize, only: [:new, :create, :update, :edit, :destory]
  before_filter :require_login, only: [:new, :create, :update, :edit, :destory]

  def new
    @title = "New Status"
    @status = Status.new(:parent_id => params[:parent_id])
    @service = Service.find(params[:service_id])
  end  
  
  def create
    @service = Service.find(params[:service_id])
    @status = Status.new(params[:status])
    @status.service_id = @service.id
    if @status.save
      flash[:notice] = "New status " + @status.message + " created."
      redirect_to service_path(@service)
    else
      flash[:error] = ap(@status.errors.full_messages)
      render :action => "new"
    end
  end
  
  def show
    @service = Service.find(params[:service_id])
    redirect_to service_path(@service)
  end
  
  def edit
    @title = "Edit Status"
    @service = Service.find(params[:service_id])
    @status = @service.statuses.find_by_id(params[:id])
  end  

  def update    
    @service = Service.find(params[:service_id])
    @status = @service.statuses.find_by_id(params[:id])
    if @status.update_attributes(params[:status])
      flash[:notice] = @status.message + " status updated."
      redirect_to service_path(@service)
    else
      flash[:error] = ap(@status.errors.full_messages)
      render :action => "edit"
    end
  end

  def destroy
    @service = Service.find(params[:service_id])
    @status = @service.statuses.find_by_id(params[:id])
    if @status.destroy
      flash[:notice] = @status.message + " status destroyed."
    else
      flash[:error] = "Error destroying status."
    end    
    redirect_to service_path(@service)
    
  end
  private
  
  def is_admin?
    service = Service.find(params[:service_id])
    service.user == current_user
  end
  
  def require_login
    unless is_admin?
      flash[:error] = "You must be the admin user to access this section."
      redirect_to services_path
    end
  end
end
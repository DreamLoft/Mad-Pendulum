class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :edit, :create, :update , :destroy]
  #skip_before_action :verify_authenticity_token ,only: [:index, :show, :new, :edit, :create, :update , :destroy]
  def index
  #  @projects= Project.all.order('created_at DESC').paginate(:page => params[:page])
  @projects = Project.where( :is_active => true).order('created_at DESC').paginate(:page => params[:page])




  end

  def show
    @project = Project.find(params[:id])
    if(current_user.isadmin == true ||  current_user.id == @project.project_manager || current_user.id== @project.project_lead )
      @timesheets= Timesheet.select{|a| a.project_id == @project.id }
    else
      @timesheets= Timesheet.select{|a| a.project_id== @project.id && a.user_id == current_user.id}
    end

    @tasks= Task.all
  end


  def new
    @users= User.all
    @projectmanagers=User.select {|a| a.is_project_manager == true}
    @projectleads= User.select {|a| a.is_project_lead == true}
    @project = Project.new
  end


  def edit
    @project = Project.find(params[:id])
    @users= User.all
    @projectmanagers=User.select {|a| a.is_project_manager == true}
    @projectleads= User.select {|a| a.is_project_lead == true}
    #render json: @project
  end


  def create
        @users= User.all
        @projectmanagers=User.select {|a| a.is_project_manager == true}
        @projectleads= User.select {|a| a.is_project_lead == true}
    @project = Project.new(project_params)
    @project.is_active= true
      if @project.save
        redirect_to @project, notice: 'Project was successfully created.'
         #Pusher.trigger('project_channel', 'add_event', @project )
       else
        render :new , notice: 'Failed to Create New Project. Please Make Sure You Filled All Details.'
     end
  end


  def update
  @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    #  Pusher.trigger('project_channel', 'update_event', @project )
    else
      render :edit
  end
end

def manage
  @project = Project.find(params[:id])
end

def destroy
  @project = Project.find(params[:id])
  Project.update(params[:id], :is_active => false )
#  @project.is_active= false
#  @project.destroy
      redirect_to projects_url, notice: 'Project was successfully destroyed.'
end

  private
  def project_params
    params.require(:project).permit(:jobid, :projectname,:clientname ,:startdate,:projectstatus, :user_id, :sbu, :project_lead, :project_manager, :close_remarks, :end_date)
  end
end

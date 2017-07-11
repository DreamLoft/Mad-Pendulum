class TasksController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :new, :edit, :create, :update , :destroy]
    #skip_before_action :verify_authenticity_token ,only: [:index, :show, :new, :edit, :create, :update , :destroy]

  def index
      #@tasks = Task.all
      @tasks = Task.all
      if (current_user.isadmin == true || current_user.ismanagement == true)
        @timesheets= Timesheet.all
      elsif (current_user.is_project_manager== true || current_user.is_project_lead== true )
        @timesheets= Timesheet.select{|a| current_user.id == Project.find(a.project_id).project_lead || current_user.id == Project.find(a.project_id).project_manager || current_user.id == a.user_id }
      else
        @timesheets= Timesheet.select{|a| a.user_id== current_user.id}
      end

      #render json: current_user
    end


  def show
      @task = Task.find(params[:id])
      if (current_user.isadmin == true || current_user.ismanagement == true || current_user.is_project_manager== true || current_user.is_project_lead== true )
        @timesheets= Timesheet.all
      else
        @timesheets= Timesheet.select{|a| a.user_id== current_user.id}
      end
    end


  def new
      @taskcategory= ['Proposal','Project Management','Briefing','Desk Research/Data Mining','Discussion Guide','Interim','Debrief','Synthesis and Opportunity Mapping','Workshop','Travel','Non-Job']
  end


  def edit
    @task= Task.find(params[:id])
    @taskcategory= ['Proposal','Project Management','Briefing','Desk Research/Data Mining','Discussion Guide','Interim','Debrief','Synthesis and Opportunity Mapping','Workshop','Travel','Non-Job']
  end


def create
  @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    #   Pusher.trigger('task_channel', 'add_event', @task)
     else
       render :new
   end
end


def update
  @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
      #Pusher.trigger('task_channel', 'update_event', @task)
    else
      render :edit
  end
end


def destroy
  @task = Task.find(params[:id])
  @task.destroy
      redirect_to tasks_url, notice: 'Task was successfully destroyed.'
end


private
  def task_params
    params.require(:task).permit(:taskname, :task_category)
  end
end

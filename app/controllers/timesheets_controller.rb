class TimesheetsController < ApplicationController
  before_action :authenticate_user!
  #skip_before_action :verify_authenticity_token ,only: [:index, :show, :new, :edit, :create, :update , :destroy]
def index
#@timesheets= Timesheet.all.order("created_at DESC")
if (current_user.isadmin == true || current_user.ismanagement == true )
  @timesheets = Timesheet.select{|a| Project.find(a.project_id).is_active == true }
elsif (current_user.is_project_manager == true || current_user.is_project_lead== true )

  @timesheets= Timesheet.select{|a|  (Project.find(a.project_id).project_lead == current_user.id ||  Project.find(a.project_id).project_manager == current_user.id ||  a.user_id == current_user.id) && Project.find(a.project_id).is_active == true }
else
  @timesheets= Timesheet.select{|a| a.user_id == current_user.id && Project.find(a.project_id).is_active == true }
end
if (!@timesheets.empty?)
  @timesheets= @timesheets .sort_by { |h| h[:created_at]}.reverse
end
  @users= User.all
  @projects = Project.where(:is_active => true)
  @tasks= Task.all
  respond_to do |format|
    format.html
    format.xlsx {
      #render xlsx: "index", filename: "my_new_filename.xlsx"
      response.headers['Content-Disposition'] = 'attachment; filename="all_timesheets.xlsx"'
    }
  end
end

def show
  @timesheet = Timesheet.find(params[:id])
@timesheets= Timesheet.select{|a| a.project_id== @timesheet.project_id && a.task_id== @timesheet.task_id && a.user_id == @timesheet.user_id}
@users= User.all
@projects = Project.all
@tasks= Task.all

end


def new
@projects=Projection.select {|a| a.user_id == current_user.id}
@tasks= Task.all
  @timesheet = Timesheet.new
#render json: @projects
end


def edit
@timesheet = Timesheet.find(params[:id])
  render json: @timesheet
end


def create
  @timesheet = Timesheet.new(timesheet_params)
  @mytimesheets= Timesheet.select {|a| (a.project_id == @timesheet.project_id) && (a.task_id == @timesheet.task_id)&& (a.user_id == @timesheet.user_id)}.pluck(:timespent)
  if(@mytimesheets.empty? && !params[:timesheet][:timespent].empty?)
        @timesheet.totaltasktime = @timesheet.timespent
 elsif (!params[:timesheet][:timespent].empty?)
         @timesheet.totaltasktime = @timesheet.timespent + (@mytimesheets.inject{|sum,x| sum +x})
  end

    if @timesheet.save
         redirect_to timesheets_path, notice: 'Timesheet was successfully created.'

    else
       render :new , notice: 'Failed to Create New Project. Please Make Sure You Filled All Details.'
    end
end


def update
@timesheet = Timesheet.find(params[:id])
  if @timesheet.update(timesheet_params)
    redirect_to @timesheet, notice: 'Timesheet was successfully updated.'


  else
   render :edit
  end
end


def destroy
@timesheet = Timesheet.find(params[:id])
@timesheet.destroy
   redirect_to timesheets_url, notice: 'Timesheet was successfully destroyed.'
end

def pipeline
  @projects = Project.select{|p| p.projectstatus== "Pipeline"}
  @tasks= Task.select{|t| t.task_category== "Proposal"}
  @timesheet = Timesheet.new

    render :pipeline
end

def filter

    @users= User.all
    @projects = Project.all
    @tasks= Task.all
    if(params[:timesheet].present?)
          if(params[:timesheet][:project_id] == "0" && params[:timesheet][:task_id] == "0" && params[:timesheet][:user_id] == "0" )
            @timesheets= Timesheet.all
          elsif (params[:timesheet][:project_id] == "0" && params[:timesheet][:task_id] == "0" && params[:timesheet][:user_id] != "0" )
            @timesheets= Timesheet.select{|t| t.user_id == params[:timesheet][:user_id].to_i }
          elsif (params[:timesheet][:project_id] == "0" && params[:timesheet][:task_id] != "0" && params[:timesheet][:user_id] == "0" )
            @timesheets= Timesheet.select{|t| t.task_id == params[:timesheet][:task_id].to_i }
          elsif (params[:timesheet][:project_id] == "0" && params[:timesheet][:task_id] != "0" && params[:timesheet][:user_id] != "0" )
            @timesheets= Timesheet.select{|t| t.task_id == params[:timesheet][:task_id].to_i && t.user_id == params[:timesheet][:user_id].to_i }
          elsif (params[:timesheet][:project_id] != "0" && params[:timesheet][:task_id] == "0" && params[:timesheet][:user_id] == "0" )
            @timesheets= Timesheet.select{|t| t.project_id == params[:timesheet][:project_id].to_i }
          elsif (params[:timesheet][:project_id] != "0" && params[:timesheet][:task_id] == "0" && params[:timesheet][:user_id] != "0" )
            @timesheets= Timesheet.select{|t| t.project_id == params[:timesheet][:project_id].to_i && t.user_id == params[:timesheet][:user_id].to_i }
          elsif (params[:timesheet][:project_id] != "0" && params[:timesheet][:task_id] != "0" && params[:timesheet][:user_id] == "0" )
            @timesheets= Timesheet.select{|t| t.project_id == params[:timesheet][:project_id].to_i && t.task_id == params[:timesheet][:task_id].to_i }
          elsif (params[:timesheet][:project_id] != "0" && params[:timesheet][:task_id] != "0" && params[:timesheet][:user_id] != "0" )
            @timesheets= Timesheet.select{|t| t.project_id == params[:timesheet][:project_id].to_i && t.task_id == params[:timesheet][:task_id].to_i && t.user_id == params[:timesheet][:user_id].to_i   }
          end
    end
respond_to do |format|
  format.html
  format.xlsx {
    #render xlsx: "index", filename: "my_new_filename.xlsx"
    response.headers['Content-Disposition'] = 'attachment; filename="timesheets.xlsx"'
  }
end
end
def data
  params.require(:timesheet).permit(:project_id, :task_id,:user_id )
  render json: params
end

private
def timesheet_params
  params.require(:timesheet).permit( :id , :project_id, :task_id,:Tdate ,:timespent, :feeling, :user_id, :totaltasktime)
end
end

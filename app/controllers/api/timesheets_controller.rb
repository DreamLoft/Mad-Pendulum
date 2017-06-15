class Api::TimesheetsController < Api::ApplicationController
     before_action :authenticate_user!
  #before_action :authenticate_user!, only: [:index, :show, :new, :edit, :create, :update , :destroy]
  #skip_before_action :verify_authenticity_token ,only: [:index, :show, :new, :edit, :create, :update , :destroy]
def index
  @timesheets= Timesheet.all
    render json: @timesheets
end



def create
  @timesheet = Timesheet.new(timesheet_params)

  @mytimesheets= Timesheet.select {|a| (a.project_id == @timesheet.project_id) && (a.task_id == @timesheet.task_id)&& (a.user_id == @timesheet.user_id)}.pluck(:timespent)
  if(@mytimesheets.empty?)
        @timesheet.totaltasktime = @timesheet.timespent
 else
         @timesheet.totaltasktime = @timesheet.timespent + (@mytimesheets.inject{|sum,x| sum +x})
  end

    if @timesheet.save
         render json: @timesheet, status: :created, location: @timesheet
        # Pusher.trigger('timesheet_channel', 'add_event', @timesheet)
    else
         render json: Timesheet.find(params[:id]), status: :conflict
  end
  rescue => e
    render json: "An Error Occured Please Try Again Later".to_json, status: :conflict
end


private
def timesheet_params
  params.require(:timesheet).permit( :id , :project_id, :task_id,:Tdate ,:timespent, :feeling, :user_id, :totaltasktime)
end
end

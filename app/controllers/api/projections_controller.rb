
class Api::ProjectionsController < Api::ApplicationController
      before_action :authenticate_user!
def index
  page_num=params[:page]
  if current_user.isadmin
    @projections= Projection.page(page_num)
  elsif (current_user.is_project_lead || current_user.is_project_manager)
    @projections= Projection.joins(:project).where("projects.sbu = ? ", current_user.Sbu).page(page_num)
  else
    @projections= Projection.where("user_id = ? ",current_user.id).page(page_num)
  end
    render json: @projections
end

def create
@projection = Projection.new(projection_params)
    if @projection.save
      render json: @projection , status: :created, location: @project

    else
      render json: @projection.errors, status: :unprocessable_entity
    end
end

private
def projection_params
  params.require(:projection).permit(:project_id, :user_id,:joindate)
end
end


class Api::ProjectionsController < Api::ApplicationController
      before_action :authenticate_user!
def index
  page_num=params[:page]
  @projections= Projection.page(page_num)
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

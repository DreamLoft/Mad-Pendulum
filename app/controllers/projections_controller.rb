class ProjectionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :edit, :create, :update , :destroy]
  #skip_before_action :verify_authenticity_token ,only: [:index, :show, :new, :edit, :create, :update , :destroy]
def index
  @projections= Projection.all
end

def show
  @projection = Projection.find(params[:id])
end

def new
end

def edit
end

def create
  @projection= Projection.new
  @projection.project_id= params[:id]
  @projection.user_id= current_user.id
  @projection.joindate= Date.today
  #render json: @projection
# @projection = Projection.new(projection_params)
     if @projection.save
       redirect_to projects_url, notice: 'Project was successfully joined.'
       #Pusher.trigger('projection_channel', 'add_event', @projection)
     else
       render :new
   end
end

def update
end

def destroy
  @projection = Projection.find(params[:id])
  @projection.destroy
      redirect_to @project, notice: 'Left Project Successfully'
end

private
def projection_params
  params.require(:projection).permit(:project_id, :user_id,:joindate)
end
end

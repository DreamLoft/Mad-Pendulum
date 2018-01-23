class Api::TasksController < Api::ApplicationController
      before_action :authenticate_user!
        #skip_before_action :verify_authenticity_token ,only: [:index, :show, :new, :edit, :create, :update , :destroy]
        def index
          page_num=params[:page]
             @tasks = Task.page(page_num)
             render json: @tasks
        end
        def destroy
          @task = Task.find(params[:id])
          @task.destroy
              render json: "Deleted", status: :destroyed
        end

 end

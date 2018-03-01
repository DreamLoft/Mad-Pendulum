class Api::ProjectsController < Api::ApplicationController
      before_action :authenticate_user!
        #skip_before_action :verify_authenticity_token
      def index
            #@projects = Project.all
            page_num=params[:page]
            if current_user.isadmin
              @projects= Project.page(page_num)
            else
              @projects = Project.where(:sbu => current_user.Sbu).page(page_num)
            end
            render json: @projects
      end

        def create
          @project = Project.new(project_params)
            if @project.save
                  render json: @project , status: :created, location: @project

            else
                  render nothing: true, status: :bad_request
            end

        end

          def update
          @project = Project.find(params[:id])
            if @project.update(project_params)
                  render json: @project , status: :ok, location: @project

            else
             render json: @project.errors, status: :unprocessable_entity
            end
        end
      private
      def project_params
        params.require(:project).permit(:jobid, :projectname,:clientname ,:startdate,:projectstatus, :user_id, :sbu, :project_lead, :is_active, :project_manager, :close_remarks, :end_date)
      end
end

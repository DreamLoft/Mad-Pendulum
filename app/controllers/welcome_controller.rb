class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def index
      #render json: params
    #--------------------------------------------- Category X-Axis Export-----------------------------------------------------------
    if (params[:project] && params[:designation])
      if !(params[:project]=="0")
        @project= Project.find(params[:project]).projectname
      else
        @project= "All Projects"
      end
      @designation=  params[:designation]
      if (params[:project] == "0" && params[:designation]== "0" )
        @timesheets= Timesheet.all
        @proposal= @timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i }
        @project_mangment= @timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i }
        @rq= @timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i }
        @discussion_guide= @timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i }
        @fieldwork= @timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i }
        @transcription_and_ca= @timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i }
        @debrief= @timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i }
        @final_presentation= @timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i }
        @non_job_Tasks= @timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasksl"}.pluck(:timespent).inject{|i,sum| sum+i }
        @leadership= @timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i }
        @travel= @timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i }
        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
        #         render json: @timesheets
      elsif (params[:project] == "0" && params[:designation] != "0" )
        @timesheets= Timesheet.select{|t| User.find(t.user_id).designation == params[:designation] }

        @proposal= @timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i }
        @project_mangment= @timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i }
        @rq= @timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i }
        @discussion_guide= @timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i }
        @fieldwork= @timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i }
        @transcription_and_ca= @timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i }
        @debrief= @timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i }
        @final_presentation= @timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i }
        @non_job_Tasks= @timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasksl"}.pluck(:timespent).inject{|i,sum| sum+i }
        @leadership= @timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i }
        @travel= @timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i }
        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:project] != "0" && params[:designation] == "0" )
        @timesheets= Timesheet.where(:project_id => params[:project].to_i)

        @proposal= @timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i }
        @project_mangment= @timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i }
        @rq= @timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i }
        @discussion_guide= @timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i }
        @fieldwork= @timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i }
        @transcription_and_ca= @timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i }
        @debrief= @timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i }
        @final_presentation= @timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i }
        @non_job_Tasks= @timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasksl"}.pluck(:timespent).inject{|i,sum| sum+i }
        @leadership= @timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i }
        @travel= @timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:project] != "0" && params[:designation] != "0" )
        @timesheets= Timesheet.select{|t| User.find(t.user_id).designation == params[:designation] && t.project_id == params[:project].to_i }

        @proposal= @timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i }
        @project_mangment= @timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i }
        @rq= @timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i }
        @discussion_guide= @timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i }
        @fieldwork= @timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i }
        @transcription_and_ca= @timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i }
        @debrief= @timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i }
        @final_presentation= @timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i }
        @non_job_Tasks= @timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasksl"}.pluck(:timespent).inject{|i,sum| sum+i }
        @leadership= @timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i }
        @travel= @timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      end
    end

    # ------------------------------------------Designation X-Axis Export--------------------------------------------------------
    if  (params[:dProject] && params[:dCategory] && params[:dTask])
      if params[:dProject]== "0"
        @project= "All Projects"
      else
        @proeject= Project.find(params[:dProject]).projectname
      end
      @category= params[:dCategory]
      if params[:dTask]=="0"
        @task= "All Task"
      else
        @task= Task.find(params[:dTask]).taskname
      end

      if (params[:dProject]=="0" && params[:dCategory] == "0" && params[:dTask] == "0")
        @timesheets= Timesheet.all

        @research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @executive_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @chief_operating_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @director= @timesheets.select{|t| User.find(t.user_id).designation == "Director" }.pluck(:timespent).inject{|i,sum| sum+i }
        @operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:dProject]=="0" && params[:dCategory] == "0" && params[:dTask] != "0")
        @timesheets= Timesheet.select{|t| t.task_id == params[:dTask].to_i }

        @research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @executive_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @chief_operating_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @director= @timesheets.select{|t| User.find(t.user_id).designation == "Director" }.pluck(:timespent).inject{|i,sum| sum+i }
        @operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:dProject]=="0" && params[:dCategory] != "0" && params[:dTask] == "0")
        @timesheets= Timesheet.select{|t| Task.find(t.task_id).task_category == params[:dCategory] }

        @research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @executive_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @chief_operating_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @director= @timesheets.select{|t| User.find(t.user_id).designation == "Director" }.pluck(:timespent).inject{|i,sum| sum+i }
        @operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:dProject]=="0" && params[:dCategory] != "0" && params[:dTask] != "0")
        @timesheets= Timesheet.select{|t| t.task_id == params[:dTask].to_i }

        @research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @executive_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @chief_operating_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @director= @timesheets.select{|t| User.find(t.user_id).designation == "Director" }.pluck(:timespent).inject{|i,sum| sum+i }
        @operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:dProject] !="0" && params[:dCategory] == "0" && params[:dTask] == "0")
        @timesheets= Timesheet.select{|t| t.project_id == params[:dProject].to_i }

        @research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @executive_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @chief_operating_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @director= @timesheets.select{|t| User.find(t.user_id).designation == "Director" }.pluck(:timespent).inject{|i,sum| sum+i }
        @operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:dProject] !="0" && params[:dCategory] == "0" && params[:dTask] != "0")
        @timesheets= Timesheet.select{|t| t.project_id == params[:dProject].to_i  && t.task_id == params[:dTask].to_i }

        @research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @executive_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @chief_operating_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @director= @timesheets.select{|t| User.find(t.user_id).designation == "Director" }.pluck(:timespent).inject{|i,sum| sum+i }
        @operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:dProject] !="0" && params[:dCategory] != "0" && params[:dTask] == "0")
        @timesheets= Timesheet.select{|t| t.project_id == params[:dProject].to_i  && Task.find(t.task_id).task_category == params[:dCategory] }

        @research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @executive_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @chief_operating_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @director= @timesheets.select{|t| User.find(t.user_id).designation == "Director" }.pluck(:timespent).inject{|i,sum| sum+i }
        @operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:dProject] !="0" && params[:dCategory] != "0" && params[:dTask] != "0")
        @timesheets= Timesheet.select{|t| t.project_id == params[:dProject].to_i  && t.task_id == params[:dTask].to_i }

        @research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_research_manager= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_vice_president= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @executive_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @chief_operating_officer=  @timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @director= @timesheets.select{|t| User.find(t.user_id).designation == "Director" }.pluck(:timespent).inject{|i,sum| sum+i }
        @operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_operations_executive= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @associate_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)" }.pluck(:timespent).inject{|i,sum| sum+i }
        @senior_manager_operations= @timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      end
    end

    #----------------------------------------------- SBU X-Axis Export---------------------------------------------------------------
    if (params[:sCategory] && params[:sDesignation])
      @category= params[:sCategory]
      @designation= params[:sDesignation]
      if (params[:sCategory] == "0" && params[:sDesignation]== "0" )
        @timesheets= Timesheet.all
        @mumbai= @timesheets.select{|t| Project.find(t.project_id).sbu == "Mumbai" }.pluck(:timespent).inject{|i,sum| sum+i }
        @delhi= @timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi" }.pluck(:timespent).inject{|i,sum| sum+i }
        @bangalore= @timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore" }.pluck(:timespent).inject{|i,sum| sum+i }
        @qcs_india= @timesheets.select{|t| Project.find(t.project_id).sbu == "QCS India" }.pluck(:timespent).inject{|i,sum| sum+i }
        @m= @timesheets.select{|t| Project.find(t.project_id).sbu == "M" }.pluck(:timespent).inject{|i,sum| sum+i }
        @ethno= @timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno" }.pluck(:timespent).inject{|i,sum| sum+i }
        @ul= @timesheets.select{|t| Project.find(t.project_id).sbu == "UL" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:sCategory] == "0" && params[:sDesignation] != "0" )
        @timesheets= Timesheet.select{|t| User.find(t.user_id).designation == params[:sDesignation] }
        @mumbai= @timesheets.select{|t| User.find(t.user_id).Sbu == "Mumbai" }.pluck(:timespent).inject{|i,sum| sum+i }
        @delhi= @timesheets.select{|t| User.find(t.user_id).Sbu == "Delhi" }.pluck(:timespent).inject{|i,sum| sum+i }
        @bangalore= @timesheets.select{|t| User.find(t.user_id).Sbu == "Bangalore" }.pluck(:timespent).inject{|i,sum| sum+i }
        @qcs_india= @timesheets.select{|t| User.find(t.user_id).Sbu == "QCS India" }.pluck(:timespent).inject{|i,sum| sum+i }
        @m= @timesheets.select{|t| Project.find(t.project_id).sbu == "M" }.pluck(:timespent).inject{|i,sum| sum+i }
        @ethno= @timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno" }.pluck(:timespent).inject{|i,sum| sum+i }
        @ul= @timesheets.select{|t| Project.find(t.project_id).sbu == "UL" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:sCategory] != "0" && params[:sDesignation] == "0" )
        @timesheets= Timesheet.select{|t| Task.find(t.task_id).task_category == params[:sCategory] }
        @mumbai= @timesheets.select{|t| User.find(t.user_id).Sbu == "Mumbai" }.pluck(:timespent).inject{|i,sum| sum+i }
        @delhi= @timesheets.select{|t| User.find(t.user_id).Sbu == "Delhi" }.pluck(:timespent).inject{|i,sum| sum+i }
        @bangalore= @timesheets.select{|t| User.find(t.user_id).Sbu == "Bangalore" }.pluck(:timespent).inject{|i,sum| sum+i }
        @qcs_india= @timesheets.select{|t| User.find(t.user_id).Sbu == "QCS India" }.pluck(:timespent).inject{|i,sum| sum+i }
        @m= @timesheets.select{|t| Project.find(t.project_id).sbu == "M" }.pluck(:timespent).inject{|i,sum| sum+i }
        @ethno= @timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno" }.pluck(:timespent).inject{|i,sum| sum+i }
        @ul= @timesheets.select{|t| Project.find(t.project_id).sbu == "UL" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif (params[:sCategory] != "0" && params[:sDesignation] != "0" )
        @timesheets= Timesheet.select{|t| Task.find(t.task_id).task_category == params[:sCategory] && User.find(t.user_id).designation == params[:sDesignation] }
        @mumbai= @timesheets.select{|t| User.find(t.user_id).Sbu == "Mumbai" }.pluck(:timespent).inject{|i,sum| sum+i }
        @delhi= @timesheets.select{|t| User.find(t.user_id).Sbu == "Delhi" }.pluck(:timespent).inject{|i,sum| sum+i }
        @bangalore= @timesheets.select{|t| User.find(t.user_id).Sbu == "Bangalore" }.pluck(:timespent).inject{|i,sum| sum+i }
        @qcs_india= @timesheets.select{|t| User.find(t.user_id).Sbu == "QCS India" }.pluck(:timespent).inject{|i,sum| sum+i }
        @m= @timesheets.select{|t| Project.find(t.project_id).sbu == "M" }.pluck(:timespent).inject{|i,sum| sum+i }
        @ethno= @timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno" }.pluck(:timespent).inject{|i,sum| sum+i }
        @ul= @timesheets.select{|t| Project.find(t.project_id).sbu == "UL" }.pluck(:timespent).inject{|i,sum| sum+i }

        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      end
    end

    # -------------------------------------------------Project X-Axis Export---------------------------------------------------------
    if  (params[:pcategory] && params[:ptask] && params[:pdesignation])
      if params[:projectcheckbox]
        @projects= Project.find(params[:projectcheckbox].map(&:to_i))
      else
        @projects= Project.all
      end
      @category=params[:pcategory]
      @designation= params[:pdesignation]
      if params[:ptask]== "0"
        @task= "All Task"
      else
        @task= Task.find(params[:ptask]).taskname
      end
      if (params[:pcategory] =="0" && params[:pdesignation] == "0")
        @timesheets= Timesheet.where("project_id IN (?)", params[:projectcheckbox].map(&:to_i))
        @pros= Hash.new
        @projects.each{ |p|
          @pros[p.projectname]= @timesheets.select{|t| t.project_id == p.id }.pluck(:timespent).inject{|i,sum| sum+i }
        }
        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif  (params[:pcategory]=="0" && params[:pdesignation] != "0")
        @t=Timesheet.where("project_id IN (?)", params[:projectcheckbox].map(&:to_i))
        @timesheets= @t.select{|t| User.find(t.user_id).designation == params[:pdesignation] }
        #  render json: @timesheets
        @pros= Hash.new
        @projects.each{ |p|
          @pros[p.projectname]= @timesheets.select{|t| t.project_id == p.id }.pluck(:timespent).inject{|i,sum| sum+i }
        }
        respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
          }
        end
      elsif  (params[:pcategory] !="0" && params[:pdesignation] == "0")
        if (params[:ptask] == "0")
          @t=Timesheet.where("project_id IN (?)", params[:projectcheckbox].map(&:to_i))
          @timesheets= @t.select{|t| Task.find(t.task_id).task_category == params[:pcategory] }
          @pros= Hash.new
          @projects.each{ |p|
            @pros[p.projectname]= @timesheets.select{|t| t.project_id == p.id }.pluck(:timespent).inject{|i,sum| sum+i }
          }
          respond_to do |format|
            format.html
            format.xlsx {
              response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
            }
          end
        elsif (params[:ptask] != "0" )
          @t=Timesheet.where("project_id IN (?)", params[:projectcheckbox].map(&:to_i))
          @timesheets= @t.select{|t|  t.task_id == params[:ptask].to_i }
          @pros= Hash.new
          @projects.each{ |p|
            @pros[p.projectname]= @timesheets.select{|t| t.project_id == p.id }.pluck(:timespent).inject{|i,sum| sum+i }
          }
          respond_to do |format|
            format.html
            format.xlsx {
              response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
            }
          end
        end
      elsif(params[:pcategory] !="0" && params[:pdesignation] != "0")
        if (params[:ptask] == "0")
          @t=Timesheet.where("project_id IN (?)", params[:projectcheckbox].map(&:to_i))
          @timesheets= @t.select{|t| Task.find(t.task_id).task_category == params[:pcategory] && User.find(t.user_id).designation == params[:pdesignation] }
          @pros= Hash.new
          @projects.each{ |p|
            @pros[p.projectname]= @timesheets.select{|t| t.project_id == p.id }.pluck(:timespent).inject{|i,sum| sum+i }
          }
          respond_to do |format|
            format.html
            format.xlsx {
              response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
            }
          end
        else
          @t=Timesheet.where("project_id IN (?)", params[:projectcheckbox].map(&:to_i))
          @timesheets= @t.select{|t| User.find(t.user_id).designation == params[:pdesignation] && t.task_id == params[:ptask].to_i }
          @pros= Hash.new
          @projects.each{ |p|
            @pros[p.projectname]= @timesheets.select{|t| t.project_id == p.id }.pluck(:timespent).inject{|i,sum| sum+i }
          }
          respond_to do |format|
            format.html
            format.xlsx {
              response.headers['Content-Disposition'] = 'attachment; filename="tSheet.xlsx"'
            }
          end
        end
      end
    end

    if (params[:categoryStackOptions])
      @categoryStack= params[:categoryStackOptions]
      @proposal_timesheets= Timesheet.select{|t| Task.find(t.task_id).task_category == "Proposal" }
      @pm_timesheets= Timesheet.select{|t| Task.find(t.task_id).task_category == "Project Management" }
      @rq_timesheets= Timesheet.select{|t| Task.find(t.task_id).task_category == "RQ" }
      @dg_timesheets= Timesheet.select{|t| Task.find(t.task_id).task_category == "Discussion Guide" }
      @fieldwork_timesheets= Timesheet.select{|t| Task.find(t.task_id).task_category == "Fieldwork" }
      @transcription_and_ca_timesheets = Timesheet.select{|t| Task.find(t.task_id).task_category == "Transcription and CA" }
      @debrief_timesheets= Timesheet.select{|t| Task.find(t.task_id).task_category == "Debrief" }
      @fp_timesheets=  Timesheet.select{|t| Task.find(t.task_id).task_category == "Final Presentation" }
      @travel_timesheets= Timesheet.select{|t| Task.find(t.task_id).task_category == "Travel" }
      @leadership_timesheets= Timesheet.select{|t| Task.find(t.task_id).task_category == "Leadership" }
      @non_job_timesheets=  Timesheet.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks" }

      @proposalCategory= Hash.new
      @pmCategory= Hash.new
      @rqCategory= Hash.new
      @dgCategory= Hash.new
      @fieldworkCategory= Hash.new
      @transcription_and_caCategory= Hash.new
      @debriefCategory= Hash.new
      @fpCategory= Hash.new
      @travelCategory= Hash.new
      @leadershipCategory= Hash.new
      @non_jobCategory= Hash.new

      if(params[:categoryStackOptions] == "feeling")
        #-------------------------------------Proposal Category-------------------------------
        @proposalCategory[:one]= @proposal_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:two]= @proposal_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:three]= @proposal_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:four]= @proposal_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:five]= @proposal_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #-----------------------------------Project Management Category---------------------------------------------------------------
        @pmCategory[:one]= @pm_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:two]= @pm_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:three]= @pm_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:four]= @pm_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:five]= @pm_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------RQ Category----------------------------------------------
        @rqCategory[:one]= @rq_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:two]= @rq_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:three]= @rq_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:four]= @rq_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:five]= @rq_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Discussion Guide Category----------------------------------------------
        @dgCategory[:one]= @dg_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:two]= @dg_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:three]= @dg_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:four]= @dg_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:five]= @dg_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Fieldwork Category----------------------------------------------
        @fieldworkCategory[:one]= @fieldwork_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:two]= @fieldwork_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:three]= @fieldwork_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:four]= @fieldwork_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:five]= @fieldwork_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Transcription and CA Category----------------------------------------------
        @transcription_and_caCategory[:one]= @transcription_and_ca_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:two]= @transcription_and_ca_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:three]= @transcription_and_ca_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:four]= @transcription_and_ca_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:five]= @transcription_and_ca_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Debrief Category----------------------------------------------
        @debriefCategory[:one]= @debrief_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:two]= @debrief_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:three]= @debrief_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:four]= @debrief_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:five]= @debrief_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Final Presentation Category----------------------------------------------
        @fpCategory[:one]= @fp_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:two]= @fp_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:three]= @fp_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:four]= @fp_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:five]= @fp_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Travel Category----------------------------------------------
        @travelCategory[:one]= @travel_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:two]= @travel_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:three]= @travel_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:four]= @travel_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:five]= @travel_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Leadership Category----------------------------------------------
        @leadershipCategory[:one]= @leadership_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:two]= @leadership_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:three]= @leadership_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:four]= @leadership_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:five]= @leadership_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Non Job Tasks Category----------------------------------------------
        @non_jobCategory[:one]= @non_job_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:two]= @non_job_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:three]= @non_job_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:four]= @non_job_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:five]= @non_job_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}

      elsif (params[:categoryStackOptions] == "sbu")
        #------------------------------------Proposal Category----------------------------------------------
        @proposalCategory[:m]= @proposal_timesheets.select{|t| Project.find(t.project_id).sbu == "M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:ethno]= @proposal_timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:ul]= @proposal_timesheets.select{|t| Project.find(t.project_id).sbu == "UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:delhi]= @proposal_timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:bangalore]= @proposal_timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Project Management Category----------------------------------------------
        @pmCategory[:m]= @pm_timesheets.select{|t| Project.find(t.project_id).sbu == "M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:ethno]= @pm_timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:ul]= @pm_timesheets.select{|t| Project.find(t.project_id).sbu == "UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:delhi]= @pm_timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:bangalore]= @pm_timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------RQ Category----------------------------------------------
        @rqCategory[:m]= @rq_timesheets.select{|t| Project.find(t.project_id).sbu == "M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:ethno]= @rq_timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:ul]= @rq_timesheets.select{|t| Project.find(t.project_id).sbu == "UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:delhi]= @rq_timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:bangalore]= @rq_timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Discussion Guide Category----------------------------------------------
        @dgCategory[:m]= @dg_timesheets.select{|t| Project.find(t.project_id).sbu == "M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:ethno]= @dg_timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:ul]= @dg_timesheets.select{|t| Project.find(t.project_id).sbu == "UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:delhi]= @dg_timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:bangalore]= @dg_timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Fieldwork Category----------------------------------------------
        @fieldworkCategory[:m]= @fieldwork_timesheets.select{|t| Project.find(t.project_id).sbu == "M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:ethno]= @fieldwork_timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:ul]= @fieldwork_timesheets.select{|t| Project.find(t.project_id).sbu == "UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:delhi]= @fieldwork_timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:bangalore]= @fieldwork_timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Transcription and CA Category----------------------------------------------
        @transcription_and_caCategory[:m]= @transcription_and_ca_timesheets.select{|t| Project.find(t.project_id).sbu == "M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:ethno]= @transcription_and_ca_timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:ul]= @transcription_and_ca_timesheets.select{|t| Project.find(t.project_id).sbu == "UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:delhi]= @transcription_and_ca_timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:bangalore]= @transcription_and_ca_timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Debrief Category----------------------------------------------
        @debriefCategory[:m]= @debrief_timesheets.select{|t| Project.find(t.project_id).sbu == "M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:ethno]= @debrief_timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:ul]= @debrief_timesheets.select{|t| Project.find(t.project_id).sbu == "UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:delhi]= @debrief_timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:bangalore]= @debrief_timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Final PresentationCategory----------------------------------------------
        @fpCategory[:m]= @fp_timesheets.select{|t| Project.find(t.project_id).sbu == "M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:ethno]= @fp_timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:ul]= @fp_timesheets.select{|t| Project.find(t.project_id).sbu == "UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:delhi]= @fp_timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:Bangalore]= @fp_timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Travel Category----------------------------------------------
        @travelCategory[:m]= @travel_timesheets.select{|t| Project.find(t.project_id).sbu == "M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:ethno]= @travel_timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:ul]= @travel_timesheets.select{|t| Project.find(t.project_id).sbu == "UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:delhi]= @travel_timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:bangalore]= @travel_timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Leadership Category----------------------------------------------
        @leadershipCategory[:m]= @leadership_timesheets.select{|t| Project.find(t.project_id).sbu == "M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:ethno]= @leadership_timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:ul]= @leadership_timesheets.select{|t| Project.find(t.project_id).sbu == "UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:delhi]= @leadership_timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:bangalore]= @leadership_timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Non Job Tasks Category----------------------------------------------
        @non_jobCategory[:m]= @non_job_timesheets.select{|t| Project.find(t.project_id).sbu == "M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:ethno]= @non_job_timesheets.select{|t| Project.find(t.project_id).sbu == "Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:ul]= @non_job_timesheets.select{|t| Project.find(t.project_id).sbu == "UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:delhi]= @non_job_timesheets.select{|t| Project.find(t.project_id).sbu == "Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:bangalore]= @non_job_timesheets.select{|t| Project.find(t.project_id).sbu == "Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}

      elsif (params[:categoryStackOptions] == "designation")
        #render json: params
          #------------------------------------Proposal Category----------------------------------------------
        @proposalCategory[:re]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:sre]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:am]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:rm]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:srm]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:avp]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:vp]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:svp]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:ceo]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:coo]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:director]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:oe]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:soe]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:amo]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:mo]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:smo]= @proposal_timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Project Management Category----------------------------------------------
        @pmCategory[:re]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:sre]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:am]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:rm]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:srm]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:avp]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:vp]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:svp]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:ceo]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:coo]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:director]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:oe]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:soe]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:amo]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:mo]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:smo]= @pm_timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------RQ Category----------------------------------------------
        @rqCategory[:re]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:sre]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:am]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:rm]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:srm]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:avp]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:vp]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:svp]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:ceo]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:coo]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:director]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:oe]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:soe]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:amo]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:mo]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:smo]= @rq_timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Discussion Guide Category----------------------------------------------
        @dgCategory[:re]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:sre]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:am]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:rm]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:srm]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:avp]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:vp]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:svp]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:ceo]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:coo]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:director]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:oe]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:soe]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:amo]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:mo]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:smo]= @dg_timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Fieldwork Category----------------------------------------------
        @fieldworkCategory[:re]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:sre]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:am]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:rm]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:srm]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:avp]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:vp]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:svp]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:ceo]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:coo]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:director]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:oe]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:soe]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:amo]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:mo]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:smo]= @fieldwork_timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Transcription and CA Category----------------------------------------------
        @transcription_and_caCategory[:re]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:sre]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:am]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:rm]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:srm]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:avp]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:vp]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:svp]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:ceo]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:coo]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:director]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:oe]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:soe]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:amo]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:mo]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:smo]= @transcription_and_ca_timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Debrief Category----------------------------------------------
        @debriefCategory[:re]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:sre]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:am]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:rm]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:srm]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:avp]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:vp]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:svp]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:ceo]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:coo]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:director]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:oe]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:soe]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:amo]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:mo]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:smo]= @debrief_timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Final Presentation Category----------------------------------------------
        @fpCategory[:re]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:sre]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:am]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:rm]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:srm]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:avp]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:vp]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:svp]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:ceo]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:coo]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:director]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:oe]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:soe]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:amo]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:mo]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:smo]= @fp_timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Travel Category----------------------------------------------
        @travelCategory[:re]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:sre]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:am]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:rm]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:srm]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:avp]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:vp]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:svp]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:ceo]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:coo]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:director]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:oe]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:soe]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:amo]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:mo]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:smo]= @travel_timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Leadership Category----------------------------------------------
        @leadershipCategory[:re]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:sre]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:am]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:rm]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:srm]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:avp]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:vp]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:svp]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:ceo]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:coo]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:director]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:oe]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:soe]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:amo]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:mo]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:smo]= @leadership_timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------Non Job Tasks Category----------------------------------------------
        @non_jobCategory[:re]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:sre]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:am]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:rm]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:srm]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:avp]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:vp]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:svp]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:ceo]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:coo]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:director]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:oe]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:soe]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:amo]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:mo]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:smo]= @non_job_timesheets.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}

      elsif (params[:categoryStackOptions] == "task")
        #--------------------------------------------------------Proposal Category------------------------------------------
        @proposalCategory[:mwc]= @proposal_timesheets.select{|t| Task.find(t.task_id).taskname == "Meeting with Client"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:ppw]= @proposal_timesheets.select{|t| Task.find(t.task_id).taskname == "Proposal pre-work"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:pw]= @proposal_timesheets.select{|t| Task.find(t.task_id).taskname == "Proposal Writing"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:ps]= @proposal_timesheets.select{|t| Task.find(t.task_id).taskname == "Proposal Supervision"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:pe]= @proposal_timesheets.select{|t| Task.find(t.task_id).taskname == "Proposal Edits"}.pluck(:timespent).inject{|i,sum| sum+i}
        @proposalCategory[:costing]= @proposal_timesheets.select{|t| Task.find(t.task_id).taskname == "Costing"}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------Project Management Category------------------------------------------
        @pmCategory[:spp]= @pm_timesheets.select{|t| Task.find(t.task_id).taskname == "Scheduling & Project Planning"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:billing]= @pm_timesheets.select{|t| Task.find(t.task_id).taskname == "Billing"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:cfu]= @pm_timesheets.select{|t| Task.find(t.task_id).taskname == "Collections follow up"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:cwc]= @pm_timesheets.select{|t| Task.find(t.task_id).taskname == "Coordination with client"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:legal]= @pm_timesheets.select{|t| Task.find(t.task_id).taskname == "Legal (NDA / Contracts)"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:back_check]= @pm_timesheets.select{|t| Task.find(t.task_id).taskname == "Back Checks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:tp]= @pm_timesheets.select{|t| Task.find(t.task_id).taskname == "Transcription Planning"}.pluck(:timespent).inject{|i,sum| sum+i}
        @pmCategory[:dda]= @pm_timesheets.select{|t| Task.find(t.task_id).taskname == "Documentation and Data archiving"}.pluck(:timespent).inject{|i,sum| sum+i}
        #----------------------------------------------------------RQ Category------------------------------------------------------
        @rqCategory[:writing]= @rq_timesheets.select{|t| Task.find(t.task_id).taskname == "RQ Writing"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:supervision]= @rq_timesheets.select{|t| Task.find(t.task_id).taskname == "RQ Supervision"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:revisions]= @rq_timesheets.select{|t| Task.find(t.task_id).taskname == "RQ Revisions"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:briefing]= @rq_timesheets.select{|t| Task.find(t.task_id).taskname == "RQ Briefing to Field"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rqCategory[:rbr]= @rq_timesheets.select{|t| Task.find(t.task_id).taskname == "Recruitment by Researchers"}.pluck(:timespent).inject{|i,sum| sum+i}
        #----------------------------------------------------------Discussion Guide Category------------------------------------------------------
        @dgCategory[:writing]= @dg_timesheets.select{|t| Task.find(t.task_id).taskname == "DG Writing"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:supervision]= @dg_timesheets.select{|t| Task.find(t.task_id).taskname == "DG Supervision"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:revisions]= @dg_timesheets.select{|t| Task.find(t.task_id).taskname == "DG Revisions"}.pluck(:timespent).inject{|i,sum| sum+i}
        @dgCategory[:moderator_briefing]= @dg_timesheets.select{|t| Task.find(t.task_id).taskname == "Moderator briefing"}.pluck(:timespent).inject{|i,sum| sum+i}
        #----------------------------------------------------------Fieldwork Category------------------------------------------------------
        @fieldworkCategory[:pfp]= @fieldwork_timesheets.select{|t| Task.find(t.task_id).taskname == "Pre-fieldwork prep"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:af]= @fieldwork_timesheets.select{|t| Task.find(t.task_id).taskname == "Attending Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:moderation]= @fieldwork_timesheets.select{|t| Task.find(t.task_id).taskname == "Moderation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:supervision]= @fieldwork_timesheets.select{|t| Task.find(t.task_id).taskname == "Supervision"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:fes]= @fieldwork_timesheets.select{|t| Task.find(t.task_id).taskname == "FES / TES Settlement"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:bs]= @fieldwork_timesheets.select{|t| Task.find(t.task_id).taskname == "Budget Sheets"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:pfd]= @fieldwork_timesheets.select{|t| Task.find(t.task_id).taskname == "Post fieldwork Downloads"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fieldworkCategory[:fn]= @fieldwork_timesheets.select{|t| Task.find(t.task_id).taskname == "Field Notes"}.pluck(:timespent).inject{|i,sum| sum+i}
        #----------------------------------------------------------Transcription and CA Category------------------------------------------------------
        @transcription_and_caCategory[:transcription]= @transcription_and_ca_timesheets.select{|t| Task.find(t.task_id).taskname == "Transcription"}.pluck(:timespent).inject{|i,sum| sum+i}
        @transcription_and_caCategory[:ca]= @transcription_and_ca_timesheets.select{|t| Task.find(t.task_id).taskname == "CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        #----------------------------------------------------------Debrief Category------------------------------------------------------
        @debriefCategory[:rt]= @debrief_timesheets.select{|t| Task.find(t.task_id).taskname == "Reading Transcripts"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:ba]= @debrief_timesheets.select{|t| Task.find(t.task_id).taskname == "Brainstorming & Analysis"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:dw]= @debrief_timesheets.select{|t| Task.find(t.task_id).taskname == "Debrief Writing"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:ds]= @debrief_timesheets.select{|t| Task.find(t.task_id).taskname == "Debrief Supervision"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:dr]= @debrief_timesheets.select{|t| Task.find(t.task_id).taskname == "Debrief Revisions"}.pluck(:timespent).inject{|i,sum| sum+i}
        @debriefCategory[:avprojuction]= @debrief_timesheets.select{|t| Task.find(t.task_id).taskname == "AV/ Production"}.pluck(:timespent).inject{|i,sum| sum+i}
        #----------------------------------------------------------Final Presentation Category------------------------------------------------------
        @fpCategory[:dp]= @fp_timesheets.select{|t| Task.find(t.task_id).taskname == "Debrief Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:wc]= @fp_timesheets.select{|t| Task.find(t.task_id).taskname == "Workshop Conceptualisation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:wp]= @fp_timesheets.select{|t| Task.find(t.task_id).taskname == "Workshop Prep"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:workshop]= @fp_timesheets.select{|t| Task.find(t.task_id).taskname == "Workshop"}.pluck(:timespent).inject{|i,sum| sum+i}
        @fpCategory[:wor]= @fp_timesheets.select{|t| Task.find(t.task_id).taskname == "Workshop Output report"}.pluck(:timespent).inject{|i,sum| sum+i}
        #----------------------------------------------------------Non Job Tasks Category------------------------------------------------------
        @non_jobCategory[:at_jedi]=  @non_job_timesheets.select{|t| Task.find(t.task_id).taskname == "At Jedi School"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:unplugged]=  @non_job_timesheets.select{|t| Task.find(t.task_id).taskname == "Unplugged"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:imagineering]=  @non_job_timesheets.select{|t| Task.find(t.task_id).taskname == "Imagineering"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:scheduling]=  @non_job_timesheets.select{|t| Task.find(t.task_id).taskname == "Scheduling"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:Emails]=  @non_job_timesheets.select{|t| Task.find(t.task_id).taskname == "Emails"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:cm]=  @non_job_timesheets.select{|t| Task.find(t.task_id).taskname == "Client meetings/discussions"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:appraisals]=  @non_job_timesheets.select{|t| Task.find(t.task_id).taskname == "Appraisals"}.pluck(:timespent).inject{|i,sum| sum+i}
        @non_jobCategory[:tt]=  @non_job_timesheets.select{|t| Task.find(t.task_id).taskname == "Team time"}.pluck(:timespent).inject{|i,sum| sum+i}
        #----------------------------------------------------------Leadership Category------------------------------------------------------
        @leadershipCategory[:visioning]= @leadership_timesheets.select{|t| Task.find(t.task_id).taskname == "Visioning"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:housekeeping]= @leadership_timesheets.select{|t| Task.find(t.task_id).taskname == "Housekeeping"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:networking]= @leadership_timesheets.select{|t| Task.find(t.task_id).taskname == "Networking"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:firefighting]= @leadership_timesheets.select{|t| Task.find(t.task_id).taskname == "Firefighting"}.pluck(:timespent).inject{|i,sum| sum+i}
        @leadershipCategory[:recruitment]= @leadership_timesheets.select{|t| Task.find(t.task_id).taskname == "Recruitment"}.pluck(:timespent).inject{|i,sum| sum+i}
        #----------------------------------------------------------Travel Category------------------------------------------------------
        @travelCategory[:road]= @travel_timesheets.select{|t| Task.find(t.task_id).taskname == "On the Road"}.pluck(:timespent).inject{|i,sum| sum+i}
        @travelCategory[:flight_mode]= @travel_timesheets.select{|t| t.task_id == 59}.pluck(:timespent).inject{|i,sum| sum+i}

      end


      #render json: params

    end
    #----------------------------------------------Designation X-Axis export the stacked Bar graph---------------
    if (params[:designationStackOption])
      @designationStack = params[:designationStackOption]
      @re_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Research Executive (RE)" }
      @sre_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Senior Research Executive (SRE)" }
      @am_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Associate Research Manager (AM)" }
      @rm_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Research Manager (RM)" }
      @srm_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Senior Research Manager (SRM)" }
      @avp_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Associate Vice President (AVP)" }
      @vp_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Vice President (VP)" }
      @svp_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Senior Vice President (SVP)" }
      @ceo_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Executive Officer (CEO)" }
      @coo_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Chief Operating Officer (COO)" }
      @director_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Director" }
      @oe_timesheets=  Timesheet.select{|t| User.find(t.user_id).designation == "Operations Executive (OE)" }
      @soe_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Senior Operations Executive (SOE)" }
      @amo_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Associate Manager Operations (AMO)" }
      @mo_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Manager Operations (MO)" }
      @smo_timesheets= Timesheet.select{|t| User.find(t.user_id).designation == "Senior Manager Operations (SMO)" }

      @reDesignation= Hash.new
      @sreDesignation= Hash.new
      @amDesignation= Hash.new
      @rmDesignation= Hash.new
      @srmDesignation= Hash.new
      @avpDesignation= Hash.new
      @vpDesignation= Hash.new
      @svpDesignation= Hash.new
      @ceoDesignation= Hash.new
      @cooDesignation= Hash.new
      @directorDesignation= Hash.new
      @oeDesignation= Hash.new
      @soeDesignation= Hash.new
      @amoDesignation= Hash.new
      @moDesignation= Hash.new
      @smoDesignation= Hash.new

      if(params[:designationStackOption] == "feeling")
        #-------------------------------------------------------------------RE Designation--------------------------------------------------------
        @reDesignation[:one]= @re_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:two]= @re_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:three]= @re_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:four]= @re_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:five]= @re_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------SRE Designation--------------------------------------------------------
        @sreDesignation[:one]= @sre_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:two]= @sre_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:three]= @sre_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:four]= @sre_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:five]= @sre_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------AM Designation--------------------------------------------------------
        @amDesignation[:one] = @am_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:two] = @am_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:three] = @am_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:four] = @am_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:five] = @am_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------------------RM Designation-----------------------------------------------
        @rmDesignation[:one]= @rm_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:two]= @rm_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:three]= @rm_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:four]= @rm_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:five]= @rm_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #-----------------------------------------------------------------SRM Designation-------------------------------------------------------
        @srmDesignation[:one]= @srm_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:two]= @srm_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:three]= @srm_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:four]= @srm_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:five]= @srm_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------------AVP Designation--------------------------------------------------------------
        @avpDesignation[:one]= @avp_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:two]= @avp_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:three]= @avp_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:four]= @avp_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:five]= @avp_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------------VP Designation--------------------------------------------------------------
        @vpDesignation[:one]= @vp_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:two]= @vp_timesheets.select{|t| t.feeling == 12}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:three]= @vp_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:four]= @vp_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:five]= @vp_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------------SVP Designation--------------------------------------------------------------
        @svpDesignation[:one]= @svp_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:two]= @svp_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:three]= @svp_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:four]= @svp_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:five]= @svp_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------------CEO Designation--------------------------------------------------------------
        @ceoDesignation[:two]= @ceo_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:one]= @ceo_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:three]= @ceo_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:four]= @ceo_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:five]= @ceo_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------------COO Designation--------------------------------------------------------------
        @cooDesignation[:one]= @coo_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:two]= @coo_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:three]= @coo_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:four]= @coo_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:five]= @coo_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------------COO Designation--------------------------------------------------------------
        @directorDesignation[:one]= @director_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:two]= @director_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:three]= @director_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:four]= @director_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:five]= @director_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------------OE Designation--------------------------------------------------------------
        @oeDesignation[:one]= @oe_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:two]= @oe_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:three]= @oe_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:four]= @oe_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:five]= @oe_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------------SOE Designation--------------------------------------------------------------
        @soeDesignation[:one]= @oe_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:two]= @oe_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:three]= @oe_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:four]= @oe_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:five]= @oe_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------------AMO Designation--------------------------------------------------------------
        @amoDesignation[:one]=@amo_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:two]=@amo_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:three]=@amo_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:four]=@amo_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:five]=@amo_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------------MO Designation--------------------------------------------------------------
        @moDesignation[:one]= @mo_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:two]= @mo_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:three]= @mo_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:four]= @mo_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:five]= @mo_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}
        #--------------------------------------------------------------SMO Designation--------------------------------------------------------------
        @smoDesignation[:one]= @smo_timesheets.select{|t| t.feeling == 1}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:two]= @smo_timesheets.select{|t| t.feeling == 2}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:three]= @smo_timesheets.select{|t| t.feeling == 3}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:four]= @smo_timesheets.select{|t| t.feeling == 4}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:five]= @smo_timesheets.select{|t| t.feeling == 5}.pluck(:timespent).inject{|i,sum| sum+i}

      elsif (params[:designationStackOption] == "category")
        #--------------------------------------------------------------RE Designation--------------------------------------------------------------
        @reDesignation[:proposal]= @re_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:project_management]= @re_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:rq]= @re_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:discussion_guide]= @re_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:fieldwork]= @re_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:transcription_and_ca]= @re_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:debrief]= @re_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:final_presentation]= @re_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:travel]= @re_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:leadership]= @re_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:non_job_tasks]= @re_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------SRE Designation--------------------------------------------------------------------------
        @sreDesignation[:proposal]= @sre_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:project_management]= @sre_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:rq]= @sre_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:discussion_guide]= @sre_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:fieldwork]= @sre_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:transcription_and_ca]= @sre_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:debrief]= @sre_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:final_presentation]= @sre_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:travel]= @sre_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:non_job_tasks]= @sre_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:leadership]= @sre_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------AM Designation--------------------------------------------------------------------------
        @amDesignation[:proposal]= @am_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:project_management]= @am_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:rq]= @am_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:discussion_guide]= @am_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:fieldwork]= @am_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:transcription_and_ca]= @am_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:debrief]= @am_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:final_presentation]= @am_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:travel]= @am_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:non_job_tasks]= @am_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:leadership]= @am_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------RM Designation--------------------------------------------------------------------------
        @rmDesignation[:proposal]= @rm_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:project_management]= @rm_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:rq]= @rm_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:discussion_guide]= @rm_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:fieldwork]= @rm_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:transcription_and_ca]= @rm_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:debrief]= @rm_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:final_presentation]= @rm_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:travel]= @rm_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:non_job_tasks]= @rm_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:leadership]= @rm_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------SRM Designation--------------------------------------------------------------------------
        @srmDesignation[:proposal]= @srm_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:project_management]= @srm_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:rq]= @srm_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:discussion_guide]= @srm_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:fieldwork]= @srm_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:transcription_and_ca]= @srm_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:debrief]= @srm_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:final_presentation]= @srm_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:travel]= @srm_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:non_job_tasks]= @srm_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:leadership]= @srm_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------AVP Designation--------------------------------------------------------------------------
        @avpDesignation[:proposal]= @avp_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:project_management]= @avp_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:rq]= @avp_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:discussion_guide]= @avp_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:fieldwork]= @avp_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:transcription_and_ca]= @avp_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:debrief]= @avp_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:final_presentation]= @avp_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:travel]= @avp_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:non_job_tasks]= @avp_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:leadership]= @avp_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------VP Designation--------------------------------------------------------------------------
        @vpDesignation[:proposal]= @vp_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:project_management]= @vp_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:rq]= @vp_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:discussion_guide]= @vp_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:fieldwork]= @vp_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:transcription_and_ca]= @vp_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:debrief]= @vp_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:final_presentation]= @vp_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:travel]= @vp_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:non_job_tasks]= @vp_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:leadership]= @vp_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------SVP Designation--------------------------------------------------------------------------
        @svpDesignation[:proposal]= @svp_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:project_management]= @svp_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:rq]= @svp_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:discussion_guide]= @svp_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:fieldwork]= @svp_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:transcription_and_ca]= @svp_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:debrief]= @svp_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:final_presentation]= @svp_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:travel]= @svp_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:non_job_tasks]= @svp_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:leadership]= @svp_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------CEO Designation--------------------------------------------------------------------------
        @ceoDesignation[:proposal]= @ceo_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:project_management]= @ceo_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:rq]= @ceo_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:discussion_guide]= @ceo_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:fieldwork]= @ceo_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:transcription_and_ca]= @ceo_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:debrief]= @ceo_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:final_presentation]= @ceo_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:travel]= @ceo_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:non_job_tasks]= @ceo_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:leadership]= @ceo_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------COO Designation--------------------------------------------------------------------------
        @cooDesignation[:proposal]= @coo_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:project_management]= @coo_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:rq]= @coo_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:discussion_guide]= @coo_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:fieldwork]= @coo_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:transcription_and_ca]= @coo_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:debrief]= @coo_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:final_presentation]= @coo_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:travel]= @coo_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:non_job_tasks]= @coo_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:leadership]= @coo_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------Director Designation--------------------------------------------------------------------------
        @directorDesignation[:proposal]= @director_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:project_management]= @director_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:rq]= @director_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:discussion_guide]= @director_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:fieldwork]= @director_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:transcription_and_ca]= @director_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:debrief]= @director_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:final_presentation]= @director_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:travel]= @director_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:non_job_tasks]= @director_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:leadership]= @director_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------OE Designation--------------------------------------------------------------------------
        @oeDesignation[:proposal]= @oe_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:project_management]= @oe_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:rq]= @oe_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:discussion_guide]= @oe_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:fieldwork]= @oe_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:transcription_and_ca]= @oe_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:debrief]= @oe_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:final_presentation]= @oe_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:travel]= @oe_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:non_job_tasks]= @oe_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:leadership]= @oe_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------SOE Designation--------------------------------------------------------------------------
        @soeDesignation[:proposal]= @soe_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:project_management]= @soe_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:rq]= @soe_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:discussion_guide]= @soe_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:fieldwork]= @soe_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:transcription_and_ca]= @soe_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:debrief]= @soe_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:final_presentation]= @soe_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:travel]= @soe_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:non_job_tasks]= @soe_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:leadership]= @soe_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------AMO Designation--------------------------------------------------------------------------
        @amoDesignation[:proposal]= @amo_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:project_management]= @amo_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:rq]= @amo_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:discussion_guide]= @amo_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:fieldwork]= @amo_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:transcription_and_ca]= @amo_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:debrief]= @amo_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:final_presentation]= @amo_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:travel]= @amo_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:non_job_tasks]= @amo_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:leadership]= @amo_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------MO Designation--------------------------------------------------------------------------
        @moDesignation[:proposal]= @mo_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:project_management]= @mo_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:rq]= @mo_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:discussion_guide]= @mo_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:fieldwork]= @mo_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:transcription_and_ca]= @mo_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:debrief]= @mo_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:final_presentation]= @mo_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:travel]= @mo_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:non_job_tasks]= @mo_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:leadership]= @mo_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
        #------------------------------------------------------SMO Designation--------------------------------------------------------------------------
        @smoDesignation[:proposal]= @smo_timesheets.select{|t| Task.find(t.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:project_management]= @smo_timesheets.select{|t| Task.find(t.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:rq]= @smo_timesheets.select{|t| Task.find(t.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:discussion_guide]= @smo_timesheets.select{|t| Task.find(t.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:fieldwork]= @smo_timesheets.select{|t| Task.find(t.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:transcription_and_ca]= @smo_timesheets.select{|t| Task.find(t.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:debrief]= @smo_timesheets.select{|t| Task.find(t.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:final_presentation]= @smo_timesheets.select{|t| Task.find(t.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:travel]= @smo_timesheets.select{|t| Task.find(t.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:non_job_tasks]= @smo_timesheets.select{|t| Task.find(t.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:leadership]= @smo_timesheets.select{|t| Task.find(t.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}

      elsif (params[:designationStackOption] == "sbu")
        #-------------------------------------------------------------------- RE Designation--------------------------------------------------------
        @reDesignation[:m]= @re_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:ethno]= @re_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:ul]= @re_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:delhi]= @re_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @reDesignation[:bangalore]= @re_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- SRE Designation--------------------------------------------------------
        @sreDesignation[:m]= @sre_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:ethno]= @sre_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:ul]= @sre_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:delhi]= @sre_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @sreDesignation[:bangalore]= @sre_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- AM Designation--------------------------------------------------------
        @amDesignation[:m]= @am_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:ethno]= @am_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:ul]= @am_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:delhi]= @am_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amDesignation[:bangalore]= @am_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- RM Designation--------------------------------------------------------
        @rmDesignation[:m]= @rm_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:ethno]= @rm_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:ul]= @rm_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:delhi]= @rm_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @rmDesignation[:bangalore]= @rm_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- SRM Designation--------------------------------------------------------
        @srmDesignation[:m]=@srm_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:ethno]=@srm_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:ul]=@srm_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:delhi]=@srm_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @srmDesignation[:bangalore]=@srm_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- AVP Designation--------------------------------------------------------
        @avpDesignation[:m]= @avp_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:ethno]= @avp_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:ul]= @avp_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:delhi]= @avp_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @avpDesignation[:bangalore]= @avp_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- VP Designation--------------------------------------------------------
        @vpDesignation[:m]= @vp_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:ethno]= @vp_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:ul]= @vp_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:delhi]= @vp_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @vpDesignation[:bangalore]= @vp_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- SVP Designation--------------------------------------------------------
        @svpDesignation[:m]= @svp_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:ethno]= @svp_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:ul]= @svp_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:delhi]= @svp_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @svpDesignation[:bangalore]= @svp_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- CEO Designation--------------------------------------------------------
        @ceoDesignation[:m]= @ceo_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:ethno]= @ceo_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:ul]= @ceo_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:delhi]= @ceo_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @ceoDesignation[:bangalore]= @ceo_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- COO Designation--------------------------------------------------------
        @cooDesignation[:m]= @coo_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:ethno]= @coo_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:ul]= @coo_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:delhi]= @coo_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @cooDesignation[:bangalore]= @coo_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- Director Designation--------------------------------------------------------
        @directorDesignation[:m]= @director_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:ethno]= @director_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:ul]= @director_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:delhi]= @director_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @directorDesignation[:bangalore]= @director_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- OE Designation--------------------------------------------------------
        @oeDesignation[:m]= @oe_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:ethno]= @oe_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:ul]= @oe_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:delhi]= @oe_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @oeDesignation[:bangalore]= @oe_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- SOE Designation--------------------------------------------------------
        @soeDesignation[:m]= @soe_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:ethno]= @soe_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:ul]= @soe_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:delhi]= @soe_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @soeDesignation[:bangalore]= @soe_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- AMO Designation--------------------------------------------------------
        @amoDesignation[:m]= @amo_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:ethno]= @amo_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:ul]= @amo_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:delhi]= @amo_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @amoDesignation[:bangalore]= @amo_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- MO Designation--------------------------------------------------------
        @moDesignation[:m]= @mo_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:ethno]= @mo_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:ul]= @mo_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:delhi]= @mo_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @moDesignation[:bangalore]= @mo_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}
        #-------------------------------------------------------------------- SMO Designation--------------------------------------------------------
        @smoDesignation[:m]= @smo_timesheets.select{|t| Project.find(t.project_id).sbu =="M"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:ethno]= @smo_timesheets.select{|t| Project.find(t.project_id).sbu =="Ethno"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:ul]= @smo_timesheets.select{|t| Project.find(t.project_id).sbu =="UL"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:delhi]= @smo_timesheets.select{|t| Project.find(t.project_id).sbu =="Delhi"}.pluck(:timespent).inject{|i,sum| sum+i}
        @smoDesignation[:bangalore]= @smo_timesheets.select{|t| Project.find(t.project_id).sbu =="Bangalore"}.pluck(:timespent).inject{|i,sum| sum+i}

      end

    #  render json: params
    end


    #----------------------------------------------SBU X-Axis export the stacked Bar graph---------------
    if (params[:sbuStackOption])
      @sbuStack= params[:sbuStackOption]
      @msbu_timesheets= Timesheet.select{|t| Project.find(t.project_id).sbu =="M"}
      @ethnosbu_timesheets= Timesheet.select{|t| Project.find(t.project_id).sbu =="Ethno"}
      @ulsbu_timesheets= Timesheet.select{|t| Project.find(t.project_id).sbu =="UL"}
      @delhisbu_timesheets= Timesheet.select{|t| Project.find(t.project_id).sbu =="Delhi"}
      @bangaloresbu_timesheets= Timesheet.select{|t| Project.find(t.project_id).sbu =="Bangalore"}
      @mSbu= Hash.new
      @ethnoSbu= Hash.new
      @ulSbu= Hash.new
      @delhiSbu= Hash.new
      @bangaloreSbu= Hash.new

      if (params[:sbuStackOption]=="category" )

        #---------------------------------------------------------------------mSBU----------------------------------------------------------
                  @mSbu[:proposal]= @msbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:project_management]= @msbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:rq]= @msbu_timesheets.select{|m| Task.find(m.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:discussion_guide]= @msbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:fieldwork]= @msbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:transcription_and_ca]= @msbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:debrief]= @msbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:final_presentation]= @msbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:travel]= @msbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:leadership]= @msbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:non_job_tasks]= @msbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}

        #-----------------------------------------------------------Ethno SBU------------------------------------------------------------------------

                    @ethnoSbu[:proposal]=@ethnosbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
                    @ethnoSbu[:project_management]=@ethnosbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
                    @ethnoSbu[:rq]=@ethnosbu_timesheets.select{|m| Task.find(m.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
                    @ethnoSbu[:discussion_guide]=@ethnosbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
                    @ethnoSbu[:fieldwork]=@ethnosbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
                    @ethnoSbu[:transcription_and_ca]=@ethnosbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
                    @ethnoSbu[:debrief]=@ethnosbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
                    @ethnoSbu[:final_presentation]=@ethnosbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
                    @ethnoSbu[:travel]=@ethnosbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
                    @ethnoSbu[:leadership]=@ethnosbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
                    @ethnoSbu[:non_job_tasks]=@ethnosbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}

                    #-----------------------------------------------------------UL SBU------------------------------------------------------------------------

                        @ulSbu[:proposal]=@ulsbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @ulSbu[:project_management]=@ulsbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @ulSbu[:rq]=@ulsbu_timesheets.select{|m| Task.find(m.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @ulSbu[:discussion_guide]=@ulsbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @ulSbu[:fieldwork]=@ulsbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @ulSbu[:transcription_and_ca]=@ulsbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @ulSbu[:debrief]=@ulsbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @ulSbu[:final_presentation]=@ulsbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @ulSbu[:travel]=@ulsbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @ulSbu[:leadership]=@ulsbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @ulSbu[:non_job_tasks]=@ulsbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}

                        #------------------------------------------------------------------Delhi SBU----------------------------------------------------------------

                        @delhiSbu[:proposal]= @delhisbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @delhiSbu[:project_management]= @delhisbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @delhiSbu[:rq]= @delhisbu_timesheets.select{|m| Task.find(m.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @delhiSbu[:discussion_guide]= @delhisbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @delhiSbu[:fieldwork]= @delhisbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @delhiSbu[:transcription_and_ca]= @delhisbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @delhiSbu[:debrief]= @delhisbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @delhiSbu[:final_presentation]= @delhisbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @delhiSbu[:travel]= @delhisbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @delhiSbu[:leadership]= @delhisbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
                        @delhiSbu[:non_job_tasks]= @delhisbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}

                        #------------------------------------------------------------------Bangalore SBU----------------------------------------------------------------

                          @bangaloreSbu[:proposal]= @bangaloresbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Proposal"}.pluck(:timespent).inject{|i,sum| sum+i}
                          @bangaloreSbu[:project_management]= @bangaloresbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Project Management"}.pluck(:timespent).inject{|i,sum| sum+i}
                          @bangaloreSbu[:rq]= @bangaloresbu_timesheets.select{|m| Task.find(m.task_id).task_category == "RQ"}.pluck(:timespent).inject{|i,sum| sum+i}
                          @bangaloreSbu[:discussion_guide]= @bangaloresbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Discussion Guide"}.pluck(:timespent).inject{|i,sum| sum+i}
                          @bangaloreSbu[:fieldwork]= @bangaloresbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Fieldwork"}.pluck(:timespent).inject{|i,sum| sum+i}
                          @bangaloreSbu[:transcription_and_ca]= @bangaloresbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Transcription and CA"}.pluck(:timespent).inject{|i,sum| sum+i}
                          @bangaloreSbu[:debrief]= @bangaloresbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Debrief"}.pluck(:timespent).inject{|i,sum| sum+i}
                          @bangaloreSbu[:final_presentation]= @bangaloresbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Final Presentation"}.pluck(:timespent).inject{|i,sum| sum+i}
                          @bangaloreSbu[:travel]= @bangaloresbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Travel"}.pluck(:timespent).inject{|i,sum| sum+i}
                          @bangaloreSbu[:leadership]= @bangaloresbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Leadership"}.pluck(:timespent).inject{|i,sum| sum+i}
                          @bangaloreSbu[:non_job_tasks]= @bangaloresbu_timesheets.select{|m| Task.find(m.task_id).task_category == "Non Job Tasks"}.pluck(:timespent).inject{|i,sum| sum+i}


          elsif(params[:sbuStackOption]=="feeling")

        #---------------------------------------------------------------------mSBU----------------------------------------------------------

                  @mSbu[:one]= @msbu_timesheets.select{|m| m.feeling== 1}.pluck(:timespent).inject{|i,sum| sum+i}
                    @mSbu[:two]= @msbu_timesheets.select{|m| m.feeling== 2}.pluck(:timespent).inject{|i,sum| sum+i}
                    @mSbu[:three]= @msbu_timesheets.select{|m| m.feeling== 3}.pluck(:timespent).inject{|i,sum| sum+i}
                     @mSbu[:four]= @msbu_timesheets.select{|m| m.feeling== 4}.pluck(:timespent).inject{|i,sum| sum+i}
                     @mSbu[:five]= @msbu_timesheets.select{|m| m.feeling== 5}.pluck(:timespent).inject{|i,sum| sum+i}

      #-----------------------------------------------------------Ethno SBU------------------------------------------------------------------------

                  @ethnoSbu[:one]=@ethnosbu_timesheets.select{|m| m.feeling== 1}.pluck(:timespent).inject{|i,sum| sum+i}
                   @ethnoSbu[:two]= @ethnosbu_timesheets.select{|m| m.feeling== 2}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:three]= @ethnosbu_timesheets.select{|m| m.feeling== 3}.pluck(:timespent).inject{|i,sum| sum+i}
                 @ethnoSbu[:four]= @ethnosbu_timesheets.select{|m| m.feeling== 4}.pluck(:timespent).inject{|i,sum| sum+i}
                   @ethnoSbu[:five] = @ethnosbu_timesheets.select{|m| m.feeling== 5}.pluck(:timespent).inject{|i,sum| sum+i}



      #-----------------------------------------------------------UL SBU------------------------------------------------------------------------

                  @ulSbu[:one]=@ulsbu_timesheets.select{|m| m.feeling== 1}.pluck(:timespent).inject{|i,sum| sum+i}
                   @ulSbu[:two]= @ulsbu_timesheets.select{|m| m.feeling== 2}.pluck(:timespent).inject{|i,sum| sum+i}
                   @ulSbu[:three]= @ulsbu_timesheets.select{|m| m.feeling== 3}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:four]= @ulsbu_timesheets.select{|m| m.feeling== 4}.pluck(:timespent).inject{|i,sum| sum+i}
                   @ulSbu[:five] = @ulsbu_timesheets.select{|m| m.feeling== 5}.pluck(:timespent).inject{|i,sum| sum+i}

      #------------------------------------------------------------------Delhi SBU----------------------------------------------------------------

          @delhiSbu[:one]= @delhisbu_timesheets.select{|m| m.feeling== 1}.pluck(:timespent).inject{|i,sum| sum+i}
           @delhiSbu[:two]= @delhisbu_timesheets.select{|m| m.feeling== 2}.pluck(:timespent).inject{|i,sum| sum+i}
           @delhiSbu[:three]= @delhisbu_timesheets.select{|m| m.feeling== 3}.pluck(:timespent).inject{|i,sum| sum+i}
          @delhiSbu[:four]= @delhisbu_timesheets.select{|m| m.feeling== 4}.pluck(:timespent).inject{|i,sum| sum+i}
           @delhiSbu[:five] = @delhisbu_timesheets.select{|m| m.feeling== 5}.pluck(:timespent).inject{|i,sum| sum+i}

      #------------------------------------------------------------------Bangalore SBU----------------------------------------------------------------

          @bangaloreSbu[:one]= @bangaloresbu_timesheets.select{|m| m.feeling== 1}.pluck(:timespent).inject{|i,sum| sum+i}
           @bangaloreSbu[:two]= @bangaloresbu_timesheets.select{|m| m.feeling== 2}.pluck(:timespent).inject{|i,sum| sum+i}
           @bangaloreSbu[:three]= @bangaloresbu_timesheets.select{|m| m.feeling== 3}.pluck(:timespent).inject{|i,sum| sum+i}
          @bangaloreSbu[:four]= @bangaloresbu_timesheets.select{|m| m.feeling== 4}.pluck(:timespent).inject{|i,sum| sum+i}
           @bangaloreSbu[:five] = @bangaloresbu_timesheets.select{|m| m.feeling== 5}.pluck(:timespent).inject{|i,sum| sum+i}


      elsif(params[:sbuStackOption]=="designation" )
        #---------------------------------------------------------------------mSBU----------------------------------------------------------
                  @mSbu[:re]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:sre]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:am]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:rm]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:srm]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:avp]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:vp]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:svp]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:ceo]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:coo]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:director]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:oe]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:soe]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:amo]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:mo]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @mSbu[:smo]= @msbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
      #-----------------------------------------------------------Ethno SBU------------------------------------------------------------------------

                  @ethnoSbu[:re]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:sre]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:am]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:rm]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:srm]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:avp]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:vp]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:svp]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:ceo]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:coo]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:director]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:oe]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:soe]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:amo]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:mo]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ethnoSbu[:smo]=@ethnosbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}

        #-----------------------------------------------------------UL SBU------------------------------------------------------------------------
                  @ulSbu[:re]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:sre]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:am]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:rm]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:srm]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:avp]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:vp]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:svp]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:ceo]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:coo]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:director]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:oe]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:soe]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:amo]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:mo]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @ulSbu[:smo]=@ulsbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}

      #------------------------------------------------------------------Delhi SBU----------------------------------------------------------------
                  @delhiSbu[:re]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:sre]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:am]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:rm]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:srm]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:avp]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:vp]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:svp]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:ceo]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:coo]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:director]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:oe]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:soe]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:amo]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:mo]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                  @delhiSbu[:smo]= @delhisbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}

    #------------------------------------------------------------------Bangalore SBU----------------------------------------------------------------

                      @bangaloreSbu[:re]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Research Executive (RE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:sre]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Research Executive (SRE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:am]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Research Manager (AM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:rm]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Research Manager (RM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:srm]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Research Manager (SRM)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:avp]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Vice President (AVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:vp]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Vice President (VP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:svp]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Vice President (SVP)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:ceo]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Executive Officer (CEO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:coo]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Chief Operating Officer (COO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:director]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Director"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:oe]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Operations Executive (OE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:soe]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Operations Executive (SOE)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:amo]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Associate Manager Operations (AMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:mo]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Manager Operations (MO)"}.pluck(:timespent).inject{|i,sum| sum+i}
                      @bangaloreSbu[:smo]= @bangaloresbu_timesheets.select{|m| User.find(m.user_id).designation == "Senior Manager Operations (SMO)"}.pluck(:timespent).inject{|i,sum| sum+i}
      end
    end

  end
def pStack
  #render json: params
    @stackOpt= params[:projectStackOptions]
  if params[:projectcheckbox]
    @projects= Project.find(params[:projectcheckbox].map(&:to_i))
  else
    @projects= Project.all
  end
  @timesheets= Timesheet.where("project_id IN (?)", params[:projectcheckbox].map(&:to_i))
  @feel= [1,2,3,4,5]
  @cats=["Proposal","Project Management","RQ","Discussion Guide","Fieldwork","Transcription and CA","Debrief","Final Presentation","Travel","Leadership","Non Job Tasks"]
  @des=["Research Executive (RE)","Senior Research Executive (SRE)","Associate Research Manager (AM)","Research Manager (RM)","Senior Research Manager (SRM)","Associate Vice President (AVP)","Vice President (VP)","Senior Vice President (SVP)","Executive Officer (CEO)","Chief Operating Officer (COO)","Director","Operations Executive (OE)","Senior Operations Executive (SOE)","Associate Manager Operations (AMO)","Manager Operations (MO)","Senior Manager Operations (SMO)"]
  @pros= Hash.new
  @color=Hash.new
  if(@stackOpt == "category")
    @projects.each{|p|
      @cats.each{ |c|
        @pros[p.projectname + c] = @timesheets.select{|t| t.project_id == p.id && Task.find(t.task_id).task_category == c }.pluck(:timespent).inject{|i,sum| sum+i }
        @color[c]= "%06x" % (rand * 0xffffff)
      }
    }
  elsif(@stackOpt == "designation")
    @projects.each{|p|
      @des.each{ |d|
        @pros[p.projectname + d] = @timesheets.select{|t| t.project_id == p.id && User.find(t.user_id).designation== d }.pluck(:timespent).inject{|i,sum| sum+i }
        @color[d]= "%06x" % (rand * 0xffffff)
      }
    }
  elsif (@stackOpt == "feeling")
    @projects.each{|p|
      @feel.each{ |f|
        @pros[p.projectname + (f.to_s)] = @timesheets.select{|t| t.project_id == p.id && t.feeling == f }.pluck(:timespent).inject{|i,sum| sum+i }
        @color[f]= "%06x" % (rand * 0xffffff)
      }
    }
  end

end

end

class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
 protect_from_forgery prepend: true

protected
def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:designation,:mobileno,:Sbu, :employee_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,:designation,:mobileno,:isadmin,:weight,:Sbu,:version, :is_project_manager, :is_project_lead, :employee_id])
end
end

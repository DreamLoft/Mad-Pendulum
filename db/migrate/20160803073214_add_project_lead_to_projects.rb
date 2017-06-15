class AddProjectLeadToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :project_lead, :integer
  end
end

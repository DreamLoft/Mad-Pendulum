class AddProjectManagerToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :project_manager, :integer
  end
end

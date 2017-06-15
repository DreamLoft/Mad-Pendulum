class RemoveLeadFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :lead, :string
  end
end

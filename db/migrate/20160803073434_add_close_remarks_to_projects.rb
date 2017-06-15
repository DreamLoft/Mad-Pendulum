class AddCloseRemarksToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :close_remarks, :string
  end
end

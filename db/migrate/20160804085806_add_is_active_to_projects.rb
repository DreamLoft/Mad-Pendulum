class AddIsActiveToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :is_active, :boolean , default: false
  end
end

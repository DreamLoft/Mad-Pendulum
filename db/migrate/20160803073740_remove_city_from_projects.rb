class RemoveCityFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :city, :string
  end
end

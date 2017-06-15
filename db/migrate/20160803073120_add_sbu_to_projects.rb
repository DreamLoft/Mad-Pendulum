class AddSbuToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :sbu, :string
  end
end

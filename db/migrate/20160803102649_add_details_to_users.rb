class AddDetailsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :employee_id, :integer ,unique: true
    add_column :users, :is_project_manager, :boolean ,default: false
    add_column :users, :is_project_lead, :boolean ,default: false
  end
end

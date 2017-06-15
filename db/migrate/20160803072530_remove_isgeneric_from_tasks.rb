class RemoveIsgenericFromTasks < ActiveRecord::Migration[5.0]
  def change
    remove_column :tasks, :isgeneric, :boolean
  end
end

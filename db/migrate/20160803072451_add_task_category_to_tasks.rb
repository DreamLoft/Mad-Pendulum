class AddTaskCategoryToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :task_category, :string
  end
end

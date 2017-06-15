class AddDetailsToTimesheets < ActiveRecord::Migration[5.0]
  def change
    add_reference :timesheets, :project, foreign_key: true
    add_reference :timesheets, :task, foreign_key: true
    add_column :timesheets, :Tdate, :date
    add_column :timesheets, :timespent, :float
    add_column :timesheets, :notes, :text
    add_column :timesheets, :feeling, :integer
    add_reference :timesheets, :user, foreign_key: true
    add_column :timesheets, :totaltasktime, :integer
  end
end

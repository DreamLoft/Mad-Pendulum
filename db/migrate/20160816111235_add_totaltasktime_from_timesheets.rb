class AddTotaltasktimeFromTimesheets < ActiveRecord::Migration[5.0]
  def change
    add_column :timesheets, :totaltasktime, :float
  end
end

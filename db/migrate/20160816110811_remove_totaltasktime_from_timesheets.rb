class RemoveTotaltasktimeFromTimesheets < ActiveRecord::Migration[5.0]
  def change
    remove_column :timesheets, :totaltasktime, :integer
  end
end

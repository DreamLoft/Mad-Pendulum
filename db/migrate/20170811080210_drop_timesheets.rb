class DropTimesheets < ActiveRecord::Migration[5.0]
  def change
    drop_table :timesheets
  end
end

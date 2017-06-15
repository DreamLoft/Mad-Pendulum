class RemoveNotesFromTimesheets < ActiveRecord::Migration[5.0]
  def change
    remove_column :timesheets, :notes, :text
  end
end

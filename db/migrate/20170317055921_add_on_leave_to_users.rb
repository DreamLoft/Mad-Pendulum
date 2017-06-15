class AddOnLeaveToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :onLeave, :boolean
  end
end

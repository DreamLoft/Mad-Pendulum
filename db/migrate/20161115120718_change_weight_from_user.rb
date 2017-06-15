class ChangeWeightFromUser < ActiveRecord::Migration[5.0]
  def change
    change_column(:users, :weight, :float)
  end
end

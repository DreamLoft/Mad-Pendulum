class AddSbuToUsers < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :Sbu, :string
    add_index  :users, :Sbu
  end

  def self.down
    remove_index  :users, :Sbu
    remove_column :users, :Sbu
  end
end

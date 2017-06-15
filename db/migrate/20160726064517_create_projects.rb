class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :jobid
      t.string :projectname
      t.string :clientname
      t.date :startdate
      t.string :projectstatus
      t.string :city
      t.string :lead

      t.timestamps
    end
  end
end

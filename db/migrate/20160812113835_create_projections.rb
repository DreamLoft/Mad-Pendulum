class CreateProjections < ActiveRecord::Migration[5.0]
  def change
    create_table :projections do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.date :joindate

      t.timestamps
    end
  end
end

class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.string :control_number
      t.string :customer
      t.timestamps
      
    end
  end
end

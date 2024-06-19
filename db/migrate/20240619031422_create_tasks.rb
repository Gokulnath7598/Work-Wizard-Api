class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :task_description
      t.string :status
      t.decimal :effort

      t.timestamps
    end
  end
end

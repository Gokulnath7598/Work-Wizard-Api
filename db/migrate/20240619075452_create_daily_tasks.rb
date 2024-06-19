class CreateDailyTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_tasks do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :task_desc

      t.timestamps
    end
  end
end

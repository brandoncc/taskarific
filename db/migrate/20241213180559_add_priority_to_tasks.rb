class AddPriorityToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :priority, :integer, default: 1
  end
end

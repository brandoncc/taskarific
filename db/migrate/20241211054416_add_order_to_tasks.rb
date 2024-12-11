class AddOrderToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :order, :integer, null: false
  end
end

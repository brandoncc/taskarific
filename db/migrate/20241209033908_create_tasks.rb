class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.belongs_to :parent, null: true
      t.string :status
      t.boolean :completed

      t.timestamps
    end
  end
end

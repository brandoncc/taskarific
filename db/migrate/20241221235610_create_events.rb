class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.text :description
      t.references :eventable, polymorphic: true, null: false, foreign_key: false

      t.timestamps
    end
  end
end

class EventsEventableShouldBeNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :events, :eventable_type, true
    change_column_null :events, :eventable_id, true
  end
end

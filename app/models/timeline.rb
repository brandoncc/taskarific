class Timeline
  def events
    Event.all.order(created_at: :desc)
  end

  def events_grouped_by_date(timezone: "Pacific Time (US & Canada)")
    events.group_by { |event| event.created_at.in_time_zone(timezone).to_date }
  end
end

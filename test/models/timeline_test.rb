require "test_helper"

class TimelineTest < ActiveSupport::TestCase
  test "#events has all events" do
    first = Event.create!(description: "first one")
    second = Event.create!(description: "second one")

    assert_equal [first, second].sort, Timeline.new.events.sort
  end

  test "#events sorts events newest first by default" do
    oldest = Event.create!(description: "first one", created_at: 1.week.ago)
    newest = Event.create!(description: "third one", created_at: 1.day.ago)
    newer = Event.create!(description: "second one", created_at: 3.days.ago)

    events = Timeline.new.events

    assert_equal newest, events.first
    assert_equal newer, events.second
    assert_equal oldest, events.third
  end

  test "#events_grouped_by_date yields each date" do
    jan_1_1 = Event.create!(description: "", created_at: Time.parse("January 1, 2024 04:30:00 PST"))
    jan_1_2 = Event.create!(description: "", created_at: Time.parse("January 1, 2024 07:30:00 PST"))
    jan_7_1 = Event.create!(description: "", created_at: Time.parse("January 7, 2024 04:30:00 PST"))
    jan_7_2 = Event.create!(description: "", created_at: Time.parse("January 7, 2024 07:30:00 PST"))
    jan_10_1 = Event.create!(description: "", created_at: Time.parse("January 10, 2024 04:30:00 PST"))
    jan_10_2 = Event.create!(description: "", created_at: Time.parse("January 10, 2024 07:30:00 PST"))

    assert_equal 3, Timeline.new.events_grouped_by_date.keys.count
  end

  test "#events_grouped_by_date yields the events for each date" do
    jan_1_1 = Event.create!(description: "", created_at: Time.parse("January 1, 2024 04:30:00 PST"))
    jan_1_2 = Event.create!(description: "", created_at: Time.parse("January 1, 2024 07:30:00 PST"))
    jan_7_1 = Event.create!(description: "", created_at: Time.parse("January 7, 2024 04:30:00 PST"))
    jan_7_2 = Event.create!(description: "", created_at: Time.parse("January 7, 2024 07:30:00 PST"))
    jan_10_1 = Event.create!(description: "", created_at: Time.parse("January 10, 2024 04:30:00 PST"))
    jan_10_2 = Event.create!(description: "", created_at: Time.parse("January 10, 2024 07:30:00 PST"))

    date_groups = Timeline.new.events_grouped_by_date.values.to_enum

    assert_equal [jan_10_1, jan_10_2].sort, date_groups.next.sort
    assert_equal [jan_7_1, jan_7_2].sort, date_groups.next.sort
    assert_equal [jan_1_1, jan_1_2].sort, date_groups.next.sort
  end
end

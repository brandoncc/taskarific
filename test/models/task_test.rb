require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = tasks(:new)
  end

  test "changing name creates a new event" do
    @task.update!(name: "starting name")

    assert_difference -> { @task.events.count }, 1 do
      @task.update!(name: "new name")
    end

    assert_includes @task.events.last.description, "starting name"
    assert_includes @task.events.last.description, "new name"
  end

  test "changing description creates a new event" do
    assert_difference -> { @task.events.count }, 1 do
      @task.update!(description: "new description")
    end
  end

  test "changing status creates a new event" do
    @task.new_status!

    assert_difference -> { @task.events.count }, 1 do
      @task.completed_status!
    end

    assert_includes @task.events.last.description, "new"
    assert_includes @task.events.last.description, "completed"
  end

  test "changing priority creates a new event" do
    @task.prioritize_today!

    assert_difference -> { @task.events.count }, 1 do
      @task.prioritize_later!
    end

    assert_includes @task.events.last.description, "today"
    assert_includes @task.events.last.description, "later"
  end

  test "changing tracking URL creates a new event" do
    @task.update!(tracking_url: "starting URL")

    assert_difference -> { @task.events.count }, 1 do
      @task.update!(tracking_url: "new URL")
    end

    assert_includes @task.events.last.description, "starting URL"
    assert_includes @task.events.last.description, "new URL"
  end
end

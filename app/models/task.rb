class Task < ApplicationRecord
  belongs_to :parent, class_name: "Task", foreign_key: :parent_id, optional: true
  has_many :subtasks, class_name: "Task", foreign_key: :parent_id, inverse_of: :parent
  has_many :events, as: :eventable

  validates_presence_of :name, :order

  before_validation :set_order

  attribute :status, default: -> { Task.statuses["new"] }

  default_scope { order(:order) }

  after_create :create_creation_events
  before_update :create_change_events
  after_destroy :clarify_orphaned_events

  enum :status, {
    new: "new",
    completed: "completed"
  }, suffix: "status"

  enum :priority, {
    today: 1,
    tomorrow: 200,
    soon: 300,
    later: 400
  }, prefix: "prioritize"

  private

  def siblings
    all_siblings =
      if parent
        parent&.subtasks || Task.none
      else
        Task.where(parent: nil)
      end

    all_siblings.where.not(id: id)
  end

  def set_order
    self.order ||= siblings.maximum(:order).to_i + 1
  end

  def create_creation_events
    events.create!(description: "task created")
  end

  def create_change_events
    create_name_change_event
    create_description_change_event
    create_status_change_event
    create_priority_change_event
    create_tracking_url_change_event
  end

  def create_name_change_event
    return unless name_changed?

    events.create!(description: "name: #{name_was} -> '#{name}'")
  end

  def create_description_change_event
    return unless description_changed?

    events.create!(description: "description changed")
  end

  def create_status_change_event
    return unless status_changed?

    events.create!(description: "status: #{status_was} -> #{status}")
  end

  def create_priority_change_event
    return unless priority_changed?

    events.create!(description: "priority: #{priority_was} -> #{priority}")
  end

  def create_tracking_url_change_event
    return unless tracking_url_changed?

    events.create!(description: "tracking_url: #{tracking_url_was} -> #{tracking_url}")
  end

  def clarify_orphaned_events
    events.each do |event|
      event.update_column(:description, "[#{name}] #{event.description}")
    end
  end
end

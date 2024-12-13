class Task < ApplicationRecord
  belongs_to :parent, class_name: "Task", foreign_key: :parent_id, optional: true
  has_many :subtasks, class_name: "Task", foreign_key: :parent_id, inverse_of: :parent

  validates_presence_of :name, :order

  before_validation :set_order

  attribute :status, default: -> { Task.statuses["new"] }

  default_scope { order(:order) }

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
end

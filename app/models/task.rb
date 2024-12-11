class Task < ApplicationRecord
  belongs_to :parent, class_name: "Task", foreign_key: :parent_id, optional: true
  has_many :subtasks, class_name: "Task", foreign_key: :parent_id, inverse_of: :parent

  validates_presence_of :name, :order

  before_validation :set_order

  default_scope { order(:order) }

  private

  def siblings
    if parent
      parent&.subtasks || Task.none
    else
      Task.where(parent: nil)
    end
  end

  def set_order
    self.order = siblings.maximum(:order).to_i + 1
  end
end

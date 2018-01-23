class Timesheet < ApplicationRecord
  validates :project_id, presence: true
  validates :task_id, presence: true
  validates :timespent, presence: true
  validates :Tdate, presence: true
  validates :user_id, presence: true
  self.per_page = 50
end

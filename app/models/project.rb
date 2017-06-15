class Project < ApplicationRecord
  validates :jobid, presence: true
 validates :projectname, presence: true, uniqueness: true
 validates :clientname, presence: true
 validates :startdate, presence: true
 validates :projectstatus, presence: true
 validates :user_id, presence: true
 validates :sbu, presence: true
 validates :project_lead, presence: true
 validates :project_manager, presence: true
 self.per_page = 10
end

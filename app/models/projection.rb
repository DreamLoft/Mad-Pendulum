class Projection < ApplicationRecord
  belongs_to :user
  belongs_to :project
   self.per_page = 50
end

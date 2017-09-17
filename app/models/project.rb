class Project < ApplicationRecord
  validates :project_name, presence:true
  validates :control_number, presence:true, length: { is: 6 }
  belongs_to :user
  validates :user_id, presence: true
  
end

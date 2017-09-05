class Project < ApplicationRecord
  validates :project_name, presence:true
  validates :control_number, presence:true, length: { is: 6 }
  
end

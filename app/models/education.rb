class Education < ActiveRecord::Base
  belongs_to :applicant
  attr_accessible :till, :college, :profession, :faculty, :diploma, :student

end

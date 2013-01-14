class Education < ActiveRecord::Base
  belongs_to :resume
  attr_accessible :year_till, :college, :profession, :faculty, :diploma, :student
  
end

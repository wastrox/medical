class Education < ActiveRecord::Base
  belongs_to :resume
  attr_accessible :year_till, :college, :profession, :faculty, :diploma, :student
  #validates_presence_of :college, :profession, :faculty, :diploma
  #validates_presence_of :year_till, :if => "student == false"
end

class Education < ActiveRecord::Base
  belongs_to :resume
  attr_accessible :till, :college, :profession, :faculty, :diploma, :student

end

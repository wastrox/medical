class ResumeRespond < ActiveRecord::Base
  attr_accessible :respond_date, :employer_id, :resume_id

  belongs_to :resume
  belongs_to :employer

  validates_uniqueness_of :employer_id, :scope => :resume_id

end

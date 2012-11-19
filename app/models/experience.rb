class Experience < ActiveRecord::Base
  belongs_to :applicant
  attr_accessible :position, :company, :achievements, :from, :till
	

end

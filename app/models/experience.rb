class Experience < ActiveRecord::Base
  belongs_to :resume
  attr_accessible :position, :company, :achievements, :from, :till
	

end

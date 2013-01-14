class Experience < ActiveRecord::Base
  belongs_to :resume
  attr_accessible :position, :company, :achievements, :month_from, :year_from, :month_till, :year_till, :current_workplace

end

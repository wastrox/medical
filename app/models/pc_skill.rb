class PcSkill < ActiveRecord::Base
  belongs_to :applicant
  attr_accessible :name, :skill 
end

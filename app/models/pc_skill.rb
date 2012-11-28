class PcSkill < ActiveRecord::Base
  belongs_to :resume
  attr_accessible :name, :skill 
end

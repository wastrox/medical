class Language < ActiveRecord::Base
  belongs_to :resume
  attr_accessible :skill, :language
end

class Language < ActiveRecord::Base
  belongs_to :applicant
  attr_accessible :skill, :language
end

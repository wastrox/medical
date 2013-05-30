class HotVacancy < ActiveRecord::Base
  belongs_to :vacancy
  attr_accessible :description
end

class Scope < ActiveRecord::Base
  attr_accessible :title

  has_many :vacancies
  has_one  :company
  has_many :categories

end

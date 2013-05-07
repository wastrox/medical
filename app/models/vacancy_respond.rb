class VacancyRespond < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :vacancy
  belongs_to :applicant

  validates_uniqueness_of :applicant_id, :scope => :vacancy_id

end

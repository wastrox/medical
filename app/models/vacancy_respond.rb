class VacancyRespond < ActiveRecord::Base
  attr_accessible :applicant_id, :vacancy_id, :respond_date, :vacancy_name

  belongs_to :vacancy
  belongs_to :applicant

  validates_uniqueness_of :applicant_id, :scope => :vacancy_id

end
class VacancyRespond < ActiveRecord::Base
  attr_accessible :applicant_id, :vacancy_id, :respond_date, :vacancy_name

  belongs_to :vacancy
  belongs_to :applicant

  validates_uniqueness_of :applicant_id, :scope => :vacancy_id

  def to_param
    vacancy_respond_name = Russian.translit(vacancy_name)
    "#{id}-#{vacancy_respond_name.parameterize}"
  end
end
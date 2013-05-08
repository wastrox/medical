class Applicant::MyVacanciesController < ApplicationController
 layout "profile_applicant"

  def index
    @applicant = Applicant.find_by_salt(cookies[:salt])
  	@vacancies = @applicant.vacancy_responds
  end
end

class Admin::Companies::VacancyController < ApplicationController
  layout "admin"
  def index
      @employer = Employer.find_by_salt(cookies[:salt])
      @vacancies = @employer.company.vacancies
  end

  def edit
  end
end

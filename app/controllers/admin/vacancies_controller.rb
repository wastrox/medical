class Admin::VacanciesController < ApplicationController
  layout "admin"
  
  def index
    @vacancies = Vacancy.all
  end

end

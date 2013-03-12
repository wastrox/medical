class Admin::Search::VacanciesController < ApplicationController
  layout "admin"
  def index
    search_params = params[:search].to_s + " " + params[:city].to_s 
		@vacancies = Vacancy.search(search_params)
  end
end

class Admin::Search::VacanciesController < ApplicationController
  layout "admin"
  http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"

  skip_before_filter :require_login

  def index
    search_params = params[:search].to_s + " " + params[:city].to_s 
		@vacancies = Vacancy.search(search_params)
  end
end

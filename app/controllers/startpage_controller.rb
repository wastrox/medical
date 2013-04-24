class StartpageController < ApplicationController
 layout "startpage"
 skip_before_filter :require_login, :only => [:index]

	def index
		#search_params = params[:search].to_s + " " + params[:city].to_s 
		#@vacancies = Vacancy.search(search_params)

		@vacancies = Vacancy.where(:state => "published").order("created_at desc").limit(10)
	end
end

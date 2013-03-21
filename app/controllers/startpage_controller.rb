class StartpageController < ApplicationController
 layout "startpage"
 skip_before_filter :require_login, :only => [:index]
	def index
	  search_params = params[:search].to_s + " " + params[:city].to_s 
		@vacancies = Vacancy.search(search_params)
	end
	
	def testIndex
	end

	def resume
	end
end

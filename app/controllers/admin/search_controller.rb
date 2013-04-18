class Admin::SearchController < ApplicationController
layout "admin"
skip_before_filter :require_login

	def index
		search_params = params[:search].to_s + " " + params[:city].to_s 

		if params[:sample] == "1"
			@vacancies = Vacancy.search(search_params)
		elsif params[:sample] =="2"
			@resumes = Resume.search(search_params)
		elsif params[:sample] == "3"
			@companies = Company.search(search_params)
		else
			@accounts = Account.search(params[:search])
		end
	end
	
end

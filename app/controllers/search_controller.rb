# coding: utf-8
class SearchController < ApplicationController
	layout "startpage"
	

	def applicant 
	end

	def vacancy
    search_params = params[:search].to_s + " " + params[:city].to_s 
		@vacancies = Vacancy.search(search_params)
	end

	def show
		if current_user.applicant?
			@vacancy = Vacancy.find(params[:id])
		else
			@employer = Applicant.find(params[:id])
		end
	end
end

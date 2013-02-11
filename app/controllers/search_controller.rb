class SearchController < ApplicationController
	layout "startpage"
	

	def applicant 
	end

	def vacancy 
		@vacancies = Vacancy.search(params[:search])
	end

	def show
		if current_user.applicant?
			@vacancy = Vacancy.find(params[:id])
		else
			@employer = Applicant.find(params[:id])
		end
	end
end

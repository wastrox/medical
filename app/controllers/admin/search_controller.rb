class Admin::SearchController < ApplicationController
layout "admin"

http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"

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
			@accounts = Account.search(params[:search], :per_page => 2000)
		end
	end

	def destroy_account_respond
		account = Account.find(params[:id])
		
		if account.employer?
		   resume_respond = ResumeRespond.find_by_employer_id(account.id).destroy unless resume_respond.nil?
		   account.company.destroy unless account.company.nil? 
		elsif account.applicant?
			vacancy_respond = VacancyRespond.find_by_applicant_id(account.id).destroy unless vacancy_respond.nil?
			account.resume.destroy unless account.resume.nil? 
		end

		if account.destroy
        	redirect_to admin_search_url
        end
	end
	
end

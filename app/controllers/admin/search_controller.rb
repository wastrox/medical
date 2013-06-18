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
			@accounts = Account.search(params[:search])
		end
	end

	def destroy_account_respond
		account = Account.find(params[:id])
		if account.employer?
		   resume_respond = ResumeRespond.find_by_employer_id(account.id).destroy unless resume_respond.nil?
		   account.company.destroy unless account.company.nil? && account.destroy
		elsif account.applicant?
			vacancy_respond = VacancyRespond.find_by_applicant_id(account.id).destroy unless vacancy_respond.nil?
			account.resume.destroy unless account.resume.nil? && account.destroy
		else
			account.destroy
		end
        redirect_to admin_search_url
	end
	
end

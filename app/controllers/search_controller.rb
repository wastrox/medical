# coding: utf-8
class SearchController < ApplicationController
	layout "search"
	skip_before_filter :require_login, :only => [:index, :resume, :vacancy, :company]
	
	def index
		search_params = params[:search].to_s + " " + params[:city].to_s 
		if params[:sample] == "1"
			@vacancies = Vacancy.search(search_params, :order => 'created_at desc')
			@title = "Поиск вакансий #{search_params}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
		else
			@resumes = Resume.search(search_params, :order => 'created_at DESC')
			@title = "Поиск резюме #{search_params}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
		end
	end

	def resume
		@resume = Resume.find(params[:id])
		@fullName = "#{@resume.profile.lastname} #{@resume.profile.firstname} #{@resume.profile.surename}"
		@title = "Резюме #{@resume.position}: работа в медицине. Сайт трудоустройства medical.netbee.ua"

	end

	def vacancy
		@vacancy = Vacancy.find(params[:id])
		@title = "Вакансия #{@vacancy.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
	end

	def company
		@company = Company.find(params[:id])
		@vacancies = @company.vacancies.where(:state => ["published", "hot"])
		@title = "Компания #{@company.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
	end
end

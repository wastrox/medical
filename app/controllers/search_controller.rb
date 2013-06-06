# coding: utf-8
# FIXME: @title, @description, @keywords -> убрать из контроллера 

class SearchController < ApplicationController
	layout "search"
	skip_before_filter :require_login, :only => [:index, :resume, :vacancy, :company]
	
	def index
		search_params = params[:search].to_s + " " + params[:city].to_s 
		if params[:sample] == "1"
			@vacancies = Vacancy.search(search_params, :order => 'created_at desc')
			@title = "Поиск вакансий: работа в медицине. Сайт трудоустройства medical.netbee.ua"
			@description = "Поиск вакансий  #{search_params}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
		else
			@resumes = Resume.search(search_params, :order => 'created_at DESC')
			@title = "Поиск резюме: работа в медицине. Сайт трудоустройства medical.netbee.ua"
			@description = "Поиск резюме #{search_params}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
		end
    	@keywords = "поиск, работа, вакансии, резюме, медицина, фармацевтика, здравоохранение, Украина, netbee"
	end

	def resume
		@resume = Resume.find(params[:id])
		@fullName = "#{@resume.profile.lastname} #{@resume.profile.firstname} #{@resume.profile.surename}"
		@title = "Резюме #{@resume.position}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
		@description = "Просмотр резюме #{@resume.position}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
	end

	def vacancy
		@vacancy = Vacancy.find(params[:id])
		@title = "Вакансия #{@vacancy.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
		@description = "Просмотр вакансии #{@vacancy.name} компании #{@vacancy.company.name}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
	end

	def company
		@company = Company.find(params[:id])
		@vacancies = @company.vacancies.where(:state => ["published", "hot"])
		@title = "Компания #{@company.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
		@description = "Просмотр компании #{@company.name}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
	end
end

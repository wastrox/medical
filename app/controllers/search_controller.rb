# coding: utf-8
# FIXME: @title, @description, @keywords -> убрать из контроллера 

class SearchController < ApplicationController
	layout "search"
	skip_before_filter :require_login, :only => [:index, :resume, :vacancy, :company, :scope, :category, :all_company]
	
	def index
		search_params = params[:search].to_s + " " + params[:city].to_s 
		if params[:sample] == "1"
			@title = "Поиск вакансий: работа в медицине. Сайт трудоустройства medical.netbee.ua"
			@description = "Поиск вакансий  #{search_params}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
			@vacancies = Vacancy.search(params[:search], :order => 'publicated_at desc').page(params[:page]).per(20)
		else
			@resumes = Resume.search(search_params, :order => 'created_at DESC').page(params[:page]).per(20)
			@title = "Поиск резюме: работа в медицине. Сайт трудоустройства medical.netbee.ua"
			@description = "Поиск резюме #{search_params}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
		end
    	@keywords = "поиск, работа, вакансии, резюме, медицина, фармацевтика, здравоохранение, Украина, netbee"
	end

	def resume
		@resume = Resume.find(params[:id])
		@top_resumes = Resume.where(:state => ["published", "hot"]).order("created_at desc").limit(3)

		@fullName = "#{@resume.profile.lastname} #{@resume.profile.firstname} #{@resume.profile.surename}"
		@title = "Резюме #{@resume.position}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
		@description = "Просмотр резюме #{@resume.position}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
		@keywords = "#{@resume.position}, поиск, работа, вакансии, резюме, медицина, фармацевтика, здравоохранение, Украина, netbee"
	end

	def vacancy
		@vacancy = Vacancy.find(params[:id])
		@top_vacancies = Vacancy.where(:state => ["published", "hot"]).order("publicated_at desc").limit(3)

		@title = "Вакансия #{@vacancy.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
		@description = "Просмотр вакансии #{@vacancy.name} компании #{@vacancy.company.name}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
		@keywords = "#{@vacancy.name}, #{@vacancy.company.name}, поиск, работа, вакансии, резюме, медицина, фармацевтика, здравоохранение, Украина, netbee"
	end

	def company
		@company = Company.find(params[:id])
		@vacancies = @company.vacancies.where(:state => ["published", "hot"])
		@title = "Компания #{@company.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
		@description = "Просмотр компании #{@company.name}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
		@keywords = "#{@company.name}, поиск, работа, вакансии, резюме, медицина, фармацевтика, здравоохранение, Украина, netbee"
	end

	def scope
		scope_array = Array.new
		@scopes = Scope.find(:all)
		@scopes.each do |s|
			scope_array << [Russian.translit(s.title).parameterize, s.id]
		end
		scope_hash = Hash[*scope_array.flatten] 		
		scope_id = scope_hash[params[:scope]]

		@scope = params[:scope]

		@categories = Category.where(:scope_id => scope_id)
		@vacancies = Vacancy.where(:category_id => @categories, :state => ["published", "hot"]).order("publicated_at desc")

		@title = "Вакансии, сфера деятельности #{Scope.find(scope_id).title}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
		@description = "Список вакансий медицинских компаний в сфере деятельности #{Scope.find(scope_id).title}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
		@keywords = "#{Scope.find(scope_id).title}, поиск, работа, вакансии, резюме, медицина, фармацевтика, здравоохранение, Украина, netbee"


	end

	def category
		category_array = Array.new
		Category.all.each do |c|
			category_array << [Russian.translit(c.name).parameterize, c.id]
		end
		category_hash = Hash[*category_array.flatten] 
		category_id = category_hash[params[:category]]

		@scope = params[:scope]
		@category = params[:category]
		@category_description = Category.find_by_id(category_id).description

		@vacancies = Vacancy.where(:category_id => category_id, :state => ["published", "hot"]).order("publicated_at desc")

		@title = "Вакансии категории #{Category.find(category_id).name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
		@description = "Список вакансий в категории #{Category.find(category_id).name}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
		@keywords = "#{Category.find(category_id).name}, поиск, работа, вакансии, резюме, медицина, фармацевтика, здравоохранение, Украина, netbee"
	end

	def all_company
		@companies = Company.where(:state => ["published", "vip"]).order("created_at desc")
	end
end

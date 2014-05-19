# coding: utf-8
# FIXME: @title, @description, @keywords -> убрать из контроллера 

class SearchController < ApplicationController
	layout "search"
	skip_before_filter :require_login, :only => [:index, :resume, :vacancy, :company, :scope, :category, :all_company, :city]
	before_filter :redirect_vacancy, :only => [:scope, :category]

	before_filter :city_seo_list, :only => [:scope, :category, :vacancy, :company, :city]

	add_breadcrumb "medical.netbee.ua", :root_path, :only => %w(vacancy city scope category)
	add_breadcrumb "поиск вакансий", { action: :index, sample: "1" }, :only => %w(vacancy city scope category)


	def index
		search_params = params[:search].to_s + " " + params[:city].to_s 
		if params[:sample] == "1"
			@title = "Поиск вакансий: работа в медицине. Сайт трудоустройства medical.netbee.ua"
			@description = "Поиск вакансий  #{search_params}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
			@vacancies = Vacancy.search(search_params, :order => 'publicated_at desc').page(params[:page]).per(20)
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

		redirect_in_true_id(@resume)
	end

	def vacancy
		vacancy = Vacancy.find(params[:id])
		@top_vacancies = Vacancy.where(:state => ["published", "hot"]).order("publicated_at desc").limit(3)

		@title = "Работа #{vacancy.name} в #{vacancy.city}: вакансии в медицине. Сайт трудоустройства medical.netbee.ua"
		@description = "Просмотр вакансии #{vacancy.name} в #{vacancy.city}, компании #{vacancy.company.name}. Большой выбор вакансий в медицинской сфере. Сайт трудоустройства medical.netbee.ua."
		@keywords = "#{vacancy.name}, #{vacancy.city}, #{vacancy.company.name}, поиск, работа, вакансии, резюме, медицина, фармацевтика, здравоохранение, Украина, netbee"

		if params[:city] && params[:city] == Russian.translit(vacancy.city).parameterize
			@vacancy = vacancy
			redirect_in_true_id(@vacancy)
		else
			redirect_to :action => action_name, :city => Russian.translit(vacancy.city).parameterize, :id => vacancy.to_param, :status => 301	
		end

		add_breadcrumb title_breadcrumbs(get_city, 'где', false), { action: :city }, title: "Работа в #{@vacancy.city}"
		add_breadcrumb @vacancy.category.scope.title.mb_chars.downcase.to_s, { action: :scope, city: params[:city] }, title: "Вакансии, работа #{title_breadcrumbs(@vacancy.category.scope, 'где', true)}"
		add_breadcrumb @vacancy.category.name.mb_chars.downcase.to_s, { action: :category, city: params[:city] }, title: "Работа #{title_breadcrumbs(@vacancy.category, 'Т', true)}"
		add_breadcrumb @vacancy.name.mb_chars.downcase.to_s, { action: :vacancy, city: params[:city] }
	end

	def company
		@company = Company.find(params[:id])
		@vacancies = @company.vacancies.where(:state => ["published", "hot"])
		@title = "Компания #{@company.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
		@description = "Просмотр компании #{@company.name}. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
		@keywords = "#{@company.name}, поиск, работа, вакансии, резюме, медицина, фармацевтика, здравоохранение, Украина, netbee"

		redirect_in_true_id(@company)
	end

	#сфера деятельности
	def scope 
		scope_array = Array.new
		@scopes = Scope.find(:all)
		@scopes.each do |s|
			scope_array << [Russian.translit(s.title).parameterize, s.id]
		end
		scope_hash = Hash[*scope_array.flatten] 		
		scope_id = scope_hash[params[:scope]]

		@scope = params[:scope]
		city = params[:city]
		@city

		@categories = Category.where(:scope_id => scope_id)
		if params[:city]
			@city = get_city.singular('где')
			@vacancies = Vacancy.where(:category_id => @categories, :city => city_name_params_translit, :state => ["published", "hot"]).order("publicated_at desc")
		else
			@vacancies = Vacancy.where(:category_id => @categories, :state => ["published", "hot"]).order("publicated_at desc")
		end

		@tag_title_by_scope = @categories.first.scope.singular('где').mb_chars.downcase.to_s

		@title = "Работа #{@tag_title_by_scope} #{@city}: вакансии в медицине. Сайт трудоустройства medical.netbee.ua."
		@description = "Работа #{@tag_title_by_scope} #{@city}. Большой выбор вакансий в медицинской сфере. Сайт трудоустройства medical.netbee.ua."
		@keywords = "Работа #{@tag_title_by_scope} #{@city}, вакансии, резюме, медицина, здравоохранение, Украина, Netbee"

		scaffold_breadcrumbs_scope(city, scope_id)
	end

	def category
		category_array = Array.new
		Category.all.each do |c|
			category_array << [Russian.translit(c.name).parameterize, c.id]
		end
		category_hash = Hash[*category_array.flatten] 
		category_id = category_hash[params[:category]]

		
		city = params[:city]
		@scope = params[:scope]
		@category = params[:category]
		@category_by_view= Category.find_by_id(category_id)
		@city

		if params[:city]
			@city = get_city.singular('где')
			@vacancies = Vacancy.where(:category_id => category_id, :city => city_name_params_translit, :state => ["published", "hot"]).order("publicated_at desc")
		else
			@vacancies = Vacancy.where(:category_id => category_id, :state => ["published", "hot"]).order("publicated_at desc")
		end

		@tag_title_by_scope = @category_by_view.scope.singular('где').mb_chars.downcase.to_s
		@tag_title_by_category = @category_by_view.singular("Т").mb_chars.downcase.to_s 
		
		@title = "Работа #{@tag_title_by_scope} #{@tag_title_by_category} #{@city}: вакансии в медицине. Сайт трудоустройства medical.netbee.ua."
		@description = "Работа #{@tag_title_by_scope} #{@tag_title_by_category} #{@city}. Большой выбор вакансий в медицинской сфере. Сайт трудоустройства medical.netbee.ua."
		@keywords = "Работа #{@tag_title_by_scope} #{@tag_title_by_category} #{@city}, вакансии, резюме, медицина, здравоохранение, Украина, Netbee"

		scaffold_breadcrumbs_category(city)
	end

	def all_company
		@vip_companies = Company.where(:state => "vip").order("created_at desc")
		@published_companies = Company.where(:state => "published").order("created_at desc").page(params[:page]).per(20)
	end

	def city
		@vacancies = Vacancy.where(:city => city_name_params_translit, :state => ["published", "hot"]).order("publicated_at desc").page(params[:page]).per(20)
		@city = City.where(name: city_name_params_translit ).first

		@title = "Работа #{@city.singular('где')}: вакансии в медицине. Сайт трудоустройства medical.netbee.ua."
		@description = "Работа #{@city.singular('где')}. Большой выбор вакансий в медицинской сфере. Сайт трудоустройства medical.netbee.ua."
		@keywords = "Работа #{@city.singular('где')}, вакансии, резюме, медицина, здравоохранение, Украина, Netbee"

		add_breadcrumb title_breadcrumbs(get_city, 'где', false), { action: :city }, title: "Работа #{get_city.singular('Р')}"
	end

	protected

	def city_class_hash
		city_array = Array.new
		City.all.each do |c|
			city_array << [Russian.translit(c.name).parameterize, c.id]
		end
		city_hash = Hash[*city_array.flatten]
		return city_hash
	end

	def city_name_params_translit
		city_id = city_class_hash[params[:city]]
		city_name = City.find(city_id).name
		return city_name
	end

	def get_city
		city_id = city_class_hash[params[:city]]
		city = City.find(city_id)
		return city
	end

	def redirect_in_true_id(str)
		if params[:id]!= str.to_param
		    redirect_to :action => action_name, :id => str.to_param, :status => 301
		end
	end

	def redirect_vacancy
	    if params[:category]
	    	vacancy = Vacancy.find(params[:category]) rescue nil
	    	if !vacancy.nil?
	    		redirect_to :action => :vacancy, :city => Russian.translit(vacancy.city).parameterize, :scope => Russian.translit(vacancy.category.scope.title).parameterize, :category => Russian.translit(vacancy.category.name).parameterize, :id => vacancy.to_param, :status => 301
	    	end
	    end
	end

	def city_seo_list
		@city_seo_list = get_city.singular("Р") if params[:city]
	end

	def title_breadcrumbs(object, case_str, downcase)
		downcase ? object.singular(case_str).mb_chars.downcase.to_s : object.singular(case_str)
	end

	def category_find(id)
		category = Category.find(id)
	end

	def scaffold_breadcrumbs_category(city)
		if city
			add_breadcrumb title_breadcrumbs(get_city, 'где', false), { action: :city }, title: "Работа #{get_city.singular('Р')}"
			add_breadcrumb @category_by_view.scope.title.mb_chars.downcase.to_s, { action: :scope, city: city}, title: "Вакансии, работа #{title_breadcrumbs(category_find(@category_by_view).scope, 'где', true)}"
			add_breadcrumb @category_by_view.name.mb_chars.downcase.to_s, { action: :category, city: city }, title: "Работа #{title_breadcrumbs(category_find(@category_by_view), 'Т', true)}", tag: :span
		else
			add_breadcrumb @category_by_view.scope.title.mb_chars.downcase.to_s, { action: :scope, city: nil}, title: "Вакансии, работа #{title_breadcrumbs(category_find(@category_by_view).scope, 'где', true)}"
			add_breadcrumb @category_by_view.name.mb_chars.downcase.to_s, { action: :category, city: nil }, title: "Работа #{title_breadcrumbs(category_find(@category_by_view), 'Т', true)}", tag: :span
		end
	end

	def scaffold_breadcrumbs_scope(city, id)
		scope = Scope.find(id)
		if city
			add_breadcrumb title_breadcrumbs(get_city, 'где', false), { action: :city }, title: "Работа #{get_city.singular('Р')}"
			add_breadcrumb scope.title.mb_chars.downcase.to_s, { action: :scope, city: city}, title: "Вакансии, работа #{title_breadcrumbs(scope, 'где', true)}"
		else
			add_breadcrumb scope.title.mb_chars.downcase.to_s, { action: :scope, city: nil}, title: "Вакансии, работа #{title_breadcrumbs(scope, 'где', true)}"
		end
	end
end

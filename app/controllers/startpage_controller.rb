class StartpageController < ApplicationController
 layout "startpage"
 skip_before_filter :require_login, :only => [:index]

	def index
		@vacancies_hot = Vacancy.where(:state => "hot").order("publicated_at desc").limit(4)
		@vacancies = Vacancy.where(:state => "published").order("publicated_at desc").limit(9)
		@companies = Company.where(:state => "vip").order("created_at desc").limit(10)
	end
end

#encoding: utf-8

class StartpageController < ApplicationController
 layout "startpage"
 skip_before_filter :require_login, :only => [:index]

	def index
		@vacancies_hot = Vacancy.where(:state => "hot").order("publicated_at desc").limit(4)
		@vacancies = Vacancy.where(:state => "published").order("publicated_at desc").limit(9)


		@companies = Company.where(:state => "vip").sort_by { rand }.slice(0..9)
		
		@header = "<h1 class='header-start-page'>Работа в медицине.</h1>"
	end
end

class StartpageController < ApplicationController
 layout "startpage"
 skip_before_filter :require_login, :only => [:index]

	def index
		@vacancies = Vacancy.where(:state => "published").order("created_at desc").limit(9)
	end
end

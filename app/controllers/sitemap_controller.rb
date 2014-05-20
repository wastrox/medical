class SitemapController < ApplicationController
	skip_before_filter :require_login

  def index 	
  	@all_city = City.all
  	@scopes = Scope.all
  end
end

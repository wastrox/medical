class SitemapController < ApplicationController

  def index 	
  	@all_city = City.all
  	@scopes = Scope.all
  end
end

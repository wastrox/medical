class SitemapController < ApplicationController
	skip_before_filter :require_login

  def index 	
  	@all_city = City.all  	
  	@scopes = Scope.all
  	@categories = Category.all

  	my_array_object = @all_city + @scopes + @categories

  	@a = Kaminari.paginate_array(my_array_object).page(params[:page]).per(150)
  end
end

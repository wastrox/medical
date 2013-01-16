class ApplicationController < ActionController::Base
http_basic_authenticate_with :name => "netbee", :password => "netbee"
  protect_from_forgery
	helper_method :current_user #Это хелпер метод контроллера, в нашем случае предназначен для использования методе current_user в любов контроллере и любой вьюхе
  before_filter :set_locale
  
  
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
    
  	def current_user
       Account.find_by_salt(cookies[:salt])  if cookies[:salt]
  	end
end

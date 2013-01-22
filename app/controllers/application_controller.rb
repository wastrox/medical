class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => "netbee", :password => "netbee"
  protect_from_forgery
	helper_method :current_user #Это хелпер, метод контроллера applicant, в нашем случае предназначен для использования методе current_user в любов контроллере и любой вьюхе
  before_filter :set_locale
  before_filter :require_login
  
  
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
    
  	def current_user
      Account.find_by_salt(cookies[:salt])  if cookies[:salt]
  	end
  	
  private
  	
  	def require_login
  	  unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_session_url
      end
  	end
  	
  	def logged_in?
      !!current_user
    end
    
    def check_account_type
      if current_user.type?
        redirect_to root_url, notice: "Logged in!"
      else
        redirect_to confirmation_account_type_url, notice: "You must choose account type!"
      end
    end
end

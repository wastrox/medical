class ApplicationController < ActionController::Base
  protect_from_forgery
	helper_method :current_user
  
  private

  	def current_user
    	@current_user ||= Account.find_by_salt(cookies[:salt]) if cookies[:salt]
  	end
end

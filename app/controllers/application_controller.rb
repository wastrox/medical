class ApplicationController < ActionController::Base
 # protect_from_forgery
	helper_method :current_user #Это хелпер метод контроллера, в нашем случае предназначен для использования методе current_user в любов контроллере и любой вьюхе
  
#  private

def test
  @asd = "test"
end
  	def current_user
  	  test
  	  return @current_user if defined?(@current_user)
      @current_user = Account.find_by_salt(cookies[:salt])  if cookies[:salt]
  	end
end

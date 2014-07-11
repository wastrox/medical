# coding: utf-8
class ApplicationController < ActionController::Base
  #http_basic_authenticate_with :name => "netbee", :password => "netbee"
  
  protect_from_forgery with: :exception
  
  helper_method :current_user
	helper_method :user_signed_in?

  before_filter :set_locale
  # before_filter :require_login

  before_filter :configure_permitted_parameters, if: :devise_controller?


    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def user_signed_in?
      account_signed_in?
    end

  	def current_user
      user_signed_in? ? current_account : false
  	end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit( :email, :password) }
      devise_parameter_sanitizer.for(:edit) { |u| u.permit( :email, :password) }
    end

  private

  	# def require_login
  	#   unless logged_in?
   #      flash[:error] = "Вы должны авторизироваться для доступа к этому разделу!"
   #      redirect_to sessions_new_url
   #    end
  	# end

  	# def logged_in?
   #    !!current_user
   #  end

    # -----------------------------------------------------------------------------------------------
    # => FIXME: блок ограничений, используется в контроллерах 'соискателей и работодателей'
    def check_account_type
      unless current_user.type?
        redirect_to confirmation_account_type_url, notice: "Вы должны выбрать тип учетной записи"
      end
    end

    def require_account_type_employer
      unless current_user.employer?
        redirect_to root_url, notice: "Нет доступа к этому разделу. Зарегистрируйтесь как работодатель"
      end
    end

    def require_account_type_applicant
      unless current_user.applicant?
        redirect_to root_url, notice: "Нет доступа к этому разделу. Зарегистрируйтесь как соискатель"
      end
    end
    # ------------------------------ *** *** *** --------------------------------------------------

    def authenticate_admin
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "admin"
      end
    end
end

# coding: utf-8
class SessionsController < ApplicationController
  layout "small_window"
  
  before_filter :find_account_by_email, :only =>  [:create, :require_active, :require_account_type, :update_time_account_activity]
  #before_filter :require_active, :only => :create FIXME: ниже есть описание проблемы
  skip_before_filter :require_login, :only => [:new, :create]
	after_filter :update_time_account_activity, :only => [:create]

  def new
    @title = "Вход на сайт трудоустройства medical.netbee.ua"
  end

  def create
    respond_to do |format|
      if @account && @account.authenticate(params[:password])
  			cookies.permanent[:salt] = @account.salt
  			flash[:notice] = "Добро пожаловать на medical.netbee.ua"
        format.html { redirect_to root_url }
      else
        flash[:notice] = "Ошибка авторизации, проверте email или пароль!"
        format.html { render "new" }
      end
    end
  end

  def destroy
    if cookies.delete(:salt)
      redirect_to root_url
    end
  end
  
  protected
  
  def find_account_by_email
    @account = Account.find_by_email(params[:email])
  end
  #---------------------------------------------------------------
  # FIXME: 
  #метод пороверки активации пользователя перед созданием сессии. 
  #Плохой метод, очень плохой метод. Работает не корректно если 
  #ошибка в email или не существует такогопользователя
  
  def require_active
    if @account.unconfirmed? 
      redirect_to confirmation_index_url, notice: "Вам было отправлено письмо, с ссылкой активации, на почту, отправить еще одно?"
    end
  end
  #-------------------------- *** -------------------------------
	
	def update_time_account_activity
		if current_user
		  @account.add_new_session_count 
			@account.update_attribute(:session_last_time, Time.new)	
		end
	end
end

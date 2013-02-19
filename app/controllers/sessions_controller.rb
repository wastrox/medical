# coding: utf-8
class SessionsController < ApplicationController
  before_filter :find_account_by_email, :only =>  [:create, :require_active, :require_account_typei, :update_time_account_activity]
  #before_filter :require_active, :only => :create FIXME: ниже есть описание проблемы
  skip_before_filter :require_login, :only => [:new, :create, :destroy]
	after_filter :update_time_account_activity, :only => [:create]

  def new
  end

  def create
    if @account && @account.authenticate(params[:password])
			cookies.permanent[:salt] = @account.salt
			redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    cookies.delete(:salt)
    redirect_to root_url, notice: "Logged out!"
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
    unless @account.active? 
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

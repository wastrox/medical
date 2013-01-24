# coding: utf-8
class SessionsController < ApplicationController
  before_filter :find_account_by_email, :only =>  [:create, :require_active, :require_account_type]
  #before_filter :require_active, :only => :create
  skip_before_filter :require_login, :only => [:new, :create, :destroy]

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
  # => FIXME: 
  #метод пороверки активации пользователя перед созданием сессии. 
  #Плохой метод, очень плохой метод. Работает не корректно если 
  #ошибка в email или не существует такогопользователя
  
  def require_active
    unless @account.active? 
      redirect_to confirmation_index_url, notice: "Вам было отправлено письмо, с ссылкой активации, на почту, отправить еще одно?"
    end
  end
  #-------------------------- *** -------------------------------
end

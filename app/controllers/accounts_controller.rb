# coding: utf-8
class AccountsController < ApplicationController
  layout "small_window"

	before_filter :find_account, :only => [:activate, :edit, :update]
  after_filter :update_time_account_activity, :only => [:activate]
	skip_before_filter :require_login, :only => [:new, :create, :activate, :recover, :email_recovery, :edit, :update]
	
  def new
    @account = Account.new
  end

  def create
   @account = Account.new(params[:account])
    if @account.save
			@account.send_activation_instructions! 
      redirect_to :controller => 'confirmation', :action => 'index'
    else
      flash[:notice] = "Ошибка регистрации!"
      render "new"
    end
  end

	def	activate # => после письма подтверждения, на этапе регистрации, если активация прошла успешно - отправляет в контроллер confirmation на страницу выбора типа account ('Даю работу', 'Ищу работу')
		if @account.activate!
			cookies.permanent[:salt] = @account.salt
			redirect_to :controller => 'confirmation', :action => 'account_type'
		else
		  redirect_to :controller => 'confirmation', :action => 'index', notice: "Аккаунт не активирован, что-то пошло не так ("
		end
	end

  def recover
    
  end

  def email_recovery
    account = Account.find_by_email(params[:email])
    account.send_password_recovery!
    redirect_to :controller => 'confirmation', :action => 'index'
  end

  def edit
  end

  def update
      if @account.update_attribute("password", params[:applicant][:password])
        cookies.permanent[:salt] = @account.salt
        redirect_to "/"
      else
        redirect_to "/"
      end
  end

  private

	def find_account
    @account = Account.find_by_token(params[:token])
  end

  def update_time_account_activity
    if current_user
      @account.add_new_session_count 
      @account.update_attribute(:session_last_time, Time.new) 
    end
  end
end

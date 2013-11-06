# coding: utf-8
class AccountsController < ApplicationController
  layout "small_window"

	before_filter :find_account, :only => [:activate, :edit, :update]
  after_filter :update_time_account_activity, :only => [:activate]
	skip_before_filter :require_login, :only => [:new, :create, :edit, :update, :activate, :recover, :email_recovery, :reactive, :active_recovery]
	
  def new
    @account = Account.new
    @title = "Регистрация на сайт трудоустройства medical.netbee.ua"
  end

  def create
   @account = Account.new(params[:account])
    if @account.save
			@account.send_activation_instructions! 
      flash[:notice] = "Вам была отправлена ссылка активации профиля на #{@account.email}. Перейдите по ссылке, указанной в этом письме."
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

  def reactive
  end

  def active_recovery
    account = Account.find_by_email(params[:email])
    if account.nil?
      flash[:notice] = "Ошибка, проверте поле email!"
      render "reactive"
    elsif account.active? == false
      account.send_activate_recovery!
      flash[:notice] = "Вам была отправлена ссылка активации профиля на #{account.email}. Перейдите по ссылке, указанной в этом письме."
      redirect_to :controller => 'confirmation', :action => 'index'
    else
      flash[:notice] = "Ошибка, Ваш профиль уже активирован."
      render "reactive"
    end
  end

  def email_recovery
    account = Account.find_by_email(params[:email])
    if account.nil?
      flash[:notice] = "Ошибка, проверте поле email!"
      render "recover"
    else
      account.send_password_recovery!
      flash[:notice] = "Вам была отправлена ссылка подтверждения профиля на #{account.email}. Перейдите по ссылке, указанной в этом письме."
      redirect_to :controller => 'confirmation', :action => 'index'
    end
  end

  def edit
  end

  def update
    #восстановления пароля
    unless current_user
      if current_user == nil && update_password(@account)
        flash[:notice] = "Пароль успешно восстановлен, авторизируйтесь."
        redirect_to sessions_new_url
      else
        error("Ошибка восстановления!")
      end
    else
      if current_user && @account.authenticate(params[:old_password])
        update_password(@account)
        new_sessions(@account)
      else
        error("Все поля должны быть заполнены верно.")
      end
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

  def new_sessions(account)
      cookies.permanent[:salt] = account.salt
      flash[:notice] = "Пароль успешно изменен."
      redirect_to :controller => 'confirmation', :action => 'index'
  end

  def error(message)
    flash[:notice] = message
    render "edit"
  end

  def update_password(account)
    case account.account_type
      when "Applicant" then param = params[:applicant]
      when "Employer" then param = params[:employer]
      when nil then param = params[:account]
    end
    account.update_attributes(:password => param.fetch("password"))
  end
end

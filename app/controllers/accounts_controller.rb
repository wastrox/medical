class AccountsController < ApplicationController
  layout "small_window"
	before_filter :find_account, :only => [:activate]
  after_filter :update_time_account_activity, :only => [:activate]
	skip_before_filter :require_login, :only => [:new, :create, :activate]
	
  def new
    @account = Account.new
  end

  def create
   @account = Account.new(params[:account])
    if @account.save
			@account.send_activation_instructions! 
      redirect_to :controller => 'confirmation', :action => 'index'
    else
      render "new"
    end
  end

	def	activate # => после письма подтверждения, на этапе регистрации, попадаем на этот контроллер, если активация прошла успешно - отправляет в контроллер confirmation на страницу выбора типа account ('Даю работу', 'Ищу работу')
		if @account.activate!
			cookies.permanent[:salt] = @account.salt
			redirect_to :controller => 'confirmation', :action => 'account_type'
		else
		  redirect_to :controller => 'confirmation', :action => 'index', notice: "Not activated, because, something went wrong ("
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

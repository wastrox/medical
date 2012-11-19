class AccountsController < ApplicationController
	before_filter :find_account, :only => [:activate]
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

	def	activate
		if @account.activate!
			cookies.permanent[:salt] = @account.salt
			redirect_to :controller => 'confirmation', :action => 'account_type'
		end
	end

  private

	def find_account
    @account = Account.find_by_token(params[:token])
  end
end

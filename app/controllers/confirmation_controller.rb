class ConfirmationController < ApplicationController
	before_filter :find_account, :only => [:applicant]	

  #Возможно стоит объединить метод index and account_type, и добавить AJAX
  def index	
  end

	def account_type
	end

	def employer
    #Update account_type in Employer and redirect the company profile
  end

  def applicant
    @account.update_type!
		redirect_to :controller => "applicants", :action => "new" if @account.type?
  end

private

  def find_account
    @account = Account.find_by_token(params[:token])
  end
end

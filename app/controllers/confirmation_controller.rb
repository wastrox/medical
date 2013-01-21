class ConfirmationController < ApplicationController
  layout "choice_worker_or_employer"
	before_filter :find_account, :only => [:applicant, :employer]	

  # => TODO: Возможно стоит объединить метод index and account_type, и добавить AJAX
  def index	
  end


  #	=> после уточнения аквиции в конроллере account -> action activate, нужно выбрать тип account -> Employer OR Applicant
	def account_type
	end

	def employer
    #Update account_type in Employer(Account.find_by_token.account_type = "Employer") and redirect the company profile

		@account.create_type("Employer")
    redirect_to new_employer_profile_company_path if @account.type?
  end

  def applicant
    @account.create_type("Applicant")
		redirect_to new_applicant_resume_path if @account.type?
  end

private

  def find_account
    @account = Account.find_by_token(params[:token])
  end

end

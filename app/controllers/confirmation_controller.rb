#encoding: UTF-8
class ConfirmationController < ApplicationController
  layout "small_window"
  
  skip_before_filter :require_login, :only => [:index, :yes, :no, :deliver_mail]
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

  def yes
  end

  def no
    @text = "Очень жаль, надеемся, что наши услуги будут полезны Вам в будущем"
  end

  def deliver_mail
    email = params[:email]
    reg = /@/
    emailValid = reg.match(email)

    if emailValid
      Notifier.letter_to_admin("Работа привалила, кто-то кликнул на YES", "Уважаемые модераторы, создайте на нашем замечательном сайте новый аккаунт #{email}").deliver
      respond_to do |format|
        format.html { redirect_to root_path }
      end  
    else
      respond_to do |format|
        flash[:notice] = "Ошибка, проверте правильность email адреса."
        format.html { render "yes" }
      end 
    end
  end

  protected

  def find_account
    @account = Account.find_by_token(params[:token])
  end
end

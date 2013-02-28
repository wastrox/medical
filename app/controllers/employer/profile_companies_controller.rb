# coding: utf-8
class Employer::ProfileCompaniesController < ApplicationController
 layout "profile_company"	
 before_filter :init_company, :only => [:new, :create]
 before_filter :find_company, :only => [:edit, :update]
 before_filter :find_employer, :only => [:create]
 before_filter :require_account_type_employer, :check_account_type

	def new
	  @company.company_contacts.build
	end
	
	def create  
 	  @company.employer = @employer
	  respond_to do |format|
      if @company.save
         @company.request # FIXME: заменить на фильтр 
         format.html { redirect_to proc { edit_employer_profile_company_url(@company)}, notes: "Компания зарегестрирована"}
         format.json { render :json => @company, :status => :created, :location => @company }
      else
         format.html { render :action => "new" }
         format.json { render :json => @company.errors, :status => :unprocessable_entity }
      end
    end
	end
	
	def edit
	end
	
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
        # ---------------------------------------------------------------
        @company.edit # FIXME: заменить на фильтр
        # когда компания была отменена модератором все вакансии ожидавшие изменения в профиле компании
        # снова отправляются на модерацию
        vacancies = @company.vacancies.where("state = ?", "wait_company")
        vacancies.each {|v| v.request}
        # _______________________________________________________________
				format.html { render :action => "edit", notes: "Edit save" }
        format.json { render :json => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "edit", notes: "Error" }
        format.json { render :json => @company.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected
  
  def init_company
    @company = Company.new(params[:company])
    @company ||= Company.new
  end
  
  def find_company
    @company = Company.find(params[:id])
  end
  
  def find_employer
    @employer = Employer.find_by_salt(cookies[:salt])
  end

end

# coding: utf-8
class Employer::VacanciesController < ApplicationController
  layout "profile_company"	
  before_filter :require_account_type_employer, :check_account_type
  before_filter :find_employer, :only => [:find_company, :index, :new, :create]
  before_filter :find_company, :only => [:index, :new, :create]
  before_filter :init_vacancy, :only => [:new, :create]
  before_filter :find_vacancy, :only => [:show, :edit, :update, :destroy]
  before_filter :find_contacts, :only => [:new, :edit]
  
  def index
    @vacancies = @company.vacancies
  end
  
  def new
  end
  
  def create 
	  respond_to do |format|
      if @vacancy.save
         format.html { redirect_to employer_vacancies_url, notes: "Вакансия создана"}
         format.json { render :json => @vacancy, :status => :created, :location => @company }
      else
         format.html { render :action => "new" }
         format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update 
    respond_to do |format|
      if @vacancy.update_attributes(params[:vacancy])
  			format.html { redirect_to employer_vacancies_url, notes: "Edit save" }
        format.json { render :json => @vacancy }
      else
        format.html { render :action => "edit", notes: "Error" }
        format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    if @vacancy.destroy
      flash[:notes] = "Deleted successfully"
    else
      flash[:notes] = "Error" 
    end
    redirect_to employer_vacancies_url
  end
  
  protected
  
  def find_employer
    @employer = Employer.find_by_salt(cookies[:salt])
  end
  
  def find_company
    @company = @employer.company
  end
  
  def init_vacancy
    @vacancy = @company.vacancies.new(params[:vacancy])
    @vacancy ||= @company.vacancies.new
  end
  
  def find_vacancy
    @vacancy = Vacancy.find(params[:id])
  end
  
  def find_contacts
    @contacts = CompanyContact.where("company_id = ?", current_user.company.id )
    #@contacts = CompanyContact.find_by_company_id(current_user.company.id)
    #@contactsHash = {"fullName" => []}
    #for c in @contacts
    #  @contactsHash["fullName"] << ['id' => c.id, 'name' => c.name, 'phone' => c.phone]
    #end
  end
end

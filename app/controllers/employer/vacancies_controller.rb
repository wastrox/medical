# coding: utf-8
# FIXME: DRY
class Employer::VacanciesController < ApplicationController
  layout "profile_company"	
  before_filter :require_account_type_employer, :check_account_type
  before_filter :find_employer, :only => [:find_company, :index, :new, :create]
  before_filter :find_company, :only => [:index, :new, :create]
  before_filter :init_vacancy, :only => [:new, :create, :check_vacancy_valid_and_save_in_draft]
  before_filter :find_vacancy, :only => [:show, :edit, :update, :destroy, :check_vacancy_valid_and_update_in_draft]
  before_filter :find_contacts, :only => [:new, :edit]
  
  def index
    @vacancies = @company.vacancies
  end
  
  def new
  end
  
  def create 
    if params[:save]
	    respond_to do |format|  
        if @vacancy.save
          @vacancy.request # FIXME: заменить на filter
          format.html { redirect_to employer_vacancies_url, notes: "Вакансия создана"}
          format.json { render :json => @vacancy, :status => :created, :location => @company }
        else
          format.html { render :action => "new" }
          format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
        end
      end
    else
      if @vacancy.save(:validate => false)
        @vacancy.drafting # FIXME: заменить на filter
        format.html { redirect_to employer_vacancies_url, notes: "Вакансия сохранена как черновик"}
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
    if params[:save]
      respond_to do |format|
        if @vacancy.update_attributes(params[:vacancy])
          @vacancy.edit #FIXME: заменить на filter
  			  format.html { redirect_to employer_vacancies_url, notes: "Edit save" }
          format.json { render :json => @vacancy }
        else
          format.html { render :action => "edit", notes: "Error" }
          format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @vacancy.attributes = params[:vacancy]
        if @vacancy.save(:validate => false)
          @vacancy.drafting #FIXME: заменить на filter
  			  format.html { redirect_to employer_vacancies_url, notes: "Сохранен как черновик" }
          format.json { render :json => @vacancy }
        else
          format.html { render :action => "edit", notes: "Error" }
          format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
        end
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
  end
end

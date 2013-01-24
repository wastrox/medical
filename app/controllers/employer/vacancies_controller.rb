# coding: utf-8
class Employer::VacanciesController < ApplicationController
  layout "profile_company"	
  before_filter :require_account_type_employer, :check_account_type
  before_filter :init_vacancy, :only => [:new, :create]
  before_filter :find_vacancy, :only => [:show, :edit, :update, :destroy]
  
  def index
    @vacancies = Vacancy.all
  end
  
  def new
  end
  
  def create
    # => FIXME: DRY --- Присвоим вакансии определенную компанию ---
	  @employer = Employer.find_by_salt(cookies[:salt])
 	  @vacancy.company = @employer.company
	  # ------------------------------------------------------------------
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
  
  def init_vacancy
    @vacancy = Vacancy.new(params[:vacancy])
    @vacancy ||= Vacancy.new
  end
  
  def find_vacancy
    @vacancy = Vacancy.find(params[:id])
  end
end

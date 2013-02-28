# encoding: utf-8
class Admin::Companies::VacancyController < ApplicationController
  layout "admin"
  before_filter :find_vacancy, :only => [:edit, :update, :find_company, :reject, :destroy, :published, :require_company_moderating]
  before_filter :find_company, :only => [:edit, :update, :reject]
  before_filter :require_company_moderating, :only => [:published]
    
  def edit
  end
  
  def update 
    respond_to do |format|
      if @vacancy.update_attributes(params[:vacancy])
  			format.html { redirect_to :controller => :profile, :action => :vacancies, :id => @company.id }
        format.json { render :json => @vacancy }
      else
        format.html { render :action => "edit", notes: "Error" }
        format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def published
    if @vacancy.approve_published
      redirect_to admin_vacancies_path, notes: "Вакансия опубликована"
    end
  end
  
  def destroy
    if @vacancy.destroy
      redirect_to admin_vacancies_path
    end
  end
  
  def reject
    if @vacancy.approve_rejected
      redirect_to admin_vacancies_path
    end
  end
  
  protected 
  
  def find_company
    @company = @vacancy.company
  end
  
  def find_vacancy
    @vacancy = Vacancy.find(params[:id])
  end
  
  def require_company_moderating
    # FIXME: заменить @vacancy.company на @company
    unless @vacancy.company.published? || @vacancy.company.vip?
      redirect_to edit_admin_companies_profile_path(@vacancy.company), notes: @vacancy.company.human_state_name
    end
  end
end

# encoding: utf-8
class Admin::Companies::VacancyController < ApplicationController
  layout "admin"
  before_filter :find_vacancy, :only => [:edit, :update, :find_company, :reject, :destroy, :require_company_moderating, :submit_name_for_form]
  before_filter :find_company, :only => [:edit, :update, :reject]
  before_filter :submit_name_for_form, :only => :edit
  #before_filter :require_company_moderating, :only => [:published] FIXME: проверка отключена, нет метода published
    
  def edit
  end
  
  def update 
    respond_to do |format|
      if @vacancy.update_attributes(params[:vacancy])
        @vacancy.approve_published unless @vacancy.published? #published
  			format.html { redirect_to :controller => :profile, :action => :vacancies, :id => @company.id }
        format.json { render :json => @vacancy }
      else
        format.html { render :action => "edit", notes: "Error" }
        format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
      end
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
  
  def submit_name_for_form
    state = @vacancy.state
    @name = case state
              when "draft", "hot", "rejected", "pending", "deferred" then "Опубликовать"
              when "published" then "Обновить"
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
    # перед публикацией вакансии, проверим была ли опубликована компания
    # FIXME: заменить @vacancy.company на @company
    unless @vacancy.company.published? || @vacancy.company.vip?
      redirect_to edit_admin_companies_profile_path(@vacancy.company), notes: @vacancy.company.human_state_name
    end
  end
end

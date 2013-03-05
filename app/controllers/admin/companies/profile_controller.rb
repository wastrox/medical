# encoding: utf-8
class Admin::Companies::ProfileController < ApplicationController
  layout "admin"
  before_filter :company_find, :only => [:edit, :update, :destroy, :vacancies, :reject, :find_vacancies_wait_company, :submit_name_for_form]
  after_filter :find_vacancies_wait_company, :only => :update
  before_filter :submit_name_for_form, :only => :edit
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
        @company.approve_published unless @company.published? #published
				format.html { redirect_to admin_companies_url }
        format.json { render :json => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "edit", notes: "Error" }
        format.json { render :json => @company.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def vacancies
    @vacancies = @company.vacancies
  end
  
  def destroy
    if @company.destroy
      redirect_to admin_companies_url
    end
  end
  
  def reject
    if @company.approve_rejected
      vacancies = @company.vacancies.where("state = ?", "pending")
      vacancies.each {|v| v.approve_wait}
      redirect_to admin_companies_url
    end
  end
  
  def submit_name_for_form
    state = @company.state
    @name = case state
              when "draft", "vip", "rejected", "pending" then "Опубликовать"
              when "published" then "Обновить"
            end
  end
  
  protected
  
  def company_find
    @company = Company.find(params[:id])
  end

  def find_vacancies_wait_company
    if @company.published?
      vacancies = @company.vacancies.where("state = ?", "wait_company")
      vacancies.each { |v| v.request } #if vacancies.present? #FIXME: проверить чтобы это условие работало если у компании нет вакансий с статусом wait_company
    end
  end  
end

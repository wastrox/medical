# encoding: utf-8
class Admin::Companies::ProfileController < ApplicationController
  layout "admin"
  before_filter :company_find, :only => [:edit, :update, :destroy, :vacancies, :reject, :published, :find_vacancies_wait_company]
  after_filter :find_vacancies_wait_company, :only => :published
  def edit
  end
  
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
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

  def published
    if @company.approve_published
      redirect_to admin_companies_path, notes: "Компания опубликована"
    end
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

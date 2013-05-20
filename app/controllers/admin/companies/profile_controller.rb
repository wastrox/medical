# encoding: utf-8
class Admin::Companies::ProfileController < ApplicationController
  layout "admin"
  
  skip_before_filter :require_login
  #before_filter :authenticate_admin #HTTP authenticate for admin; this method in place application_controller

  before_filter :company_find, :only => [:edit, :update, :destroy, :vacancies, :reject, :find_vacancies_wait_company, :published, :send_letter_for_employer, :vip]
  after_filter  :published, :only => :update
  after_filter  :reject, :only => :update
  after_filter  :vip, :only => :update
  before_filter :destroy, :only => :update
  
  def vacancies
    @vacancies = @company.vacancies
  end
  
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
  
  def published
    if params[:published] && @company.approve_published
       find_vacancies_wait_company 
       Notifier.letter_to_company_from_moderator_published(@company.employer).deliver
    end
  end
  
  def vip
    params[:vip] && @company.approve_vip   
  end

  def reject
    if params[:reject] && @company.approve_rejected
       vacancies = @company.vacancies.where("state = ?", "pending")
       vacancies.each {|v| v.approve_wait}
       Notifier.letter_to_company_from_moderator_reject(@company.employer, params[:body_letter]).deliver
    end
  end
  
  def destroy
    if params[:destroy] && @company.destroy
       send_letter_for_employer
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
      vacancies.each { |v| v.request }
    end
  end  
end

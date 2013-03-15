# encoding: utf-8
class Admin::Companies::VacancyController < ApplicationController
  layout "admin"
  before_filter :find_vacancy, :only => [:edit, :update, :find_company, :reject, :destroy, :require_company_moderating, :published]
  before_filter :find_company, :only => [:edit, :update, :reject, :send_letter_for_employer]
  after_filter  :published, :only => :update  
  
  def edit
  end
  
  def update
     respond_to do |format|
      if @vacancy.update_attributes(params[:vacancy])
        send_letter_for_employer unless params[:body_letter].empty? # FIXME: Добавить фильтром
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
      send_letter_for_employer unless params[:body_letter].empty?
      redirect_to admin_vacancies_path
    end
  end
  
  def reject
    if @vacancy.approve_rejected
      send_letter_for_employer unless params[:body_letter].empty?
      redirect_to admin_vacancies_path
    end
  end
  
  def published
    if params[:published]
      case @vacancy.state
        when "pending", "hot", "rejected", "deferred"
          @vacancy.approve_published
          send_letter_for_employer unless params[:body_letter].empty?
      end
    end
  end
  
  protected 
  
  def find_company
    @company = @vacancy.company
  end
  
  def find_vacancy
    @vacancy = Vacancy.find(params[:id])
  end
  
  def send_letter_for_employer
    case @company.state
      when "pending", "published", "hot", "rejected", "deferred"
        @company.employer.send_letter_from_moderator(params[:body_letter])
    end
  end
end

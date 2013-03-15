# encoding: utf-8
class Admin::Companies::VacancyController < ApplicationController
  layout "admin"
  before_filter :find_vacancy, :only => [:edit, :update, :find_company, :reject, :destroy, :published]
  before_filter :find_company, :only => [:edit, :update, :send_letter_for_employer]
  after_filter  :send_letter_for_employer, :only => :update
  after_filter  :published, :only => :update
  after_filter  :reject, :only => :update
  before_filter :destroy, :only => :update  
  
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
    if params[:published]
       @vacancy.approve_published
    end
  end
  
  def reject
    if params[:reject]
       @vacancy.approve_rejected
    end
  end
  
  def destroy
    if params[:destroy] && @vacancy.destroy
      send_letter_for_employer
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
  
  def send_letter_for_employer
    unless params[:body_letter].empty? 
        @company.employer.send_letter_from_moderator(params[:body_letter])
    end
  end
end

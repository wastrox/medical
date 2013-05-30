# encoding: utf-8
class Admin::Companies::VacancyController < ApplicationController
  layout "admin"

  http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"

  skip_before_filter :require_login
  before_filter :find_vacancy, :only => [:edit, :update, :find_company, :reject, :destroy, :published]
  before_filter :find_company, :only => [:edit, :update, :send_letter_for_employer]
  after_filter  :published, :only => :update
  after_filter  :hot, :only => :update
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
       if @vacancy.hot_vacancy.nil? == false
          @vacancy.hot_vacancy.delete
       end
       Notifier.letter_to_vacancy_from_moderator_published(@company.employer, @vacancy).deliver
    end
  end

  def hot
    if params[:hot]
      @vacancy.approve_hot
    end
  end
  
  def reject
    if params[:reject]
       @vacancy.approve_rejected
       Notifier.letter_to_vacancy_from_moderator_reject(@company.employer, @vacancy, params[:body_letter]).deliver
    end
  end
  
  def destroy
    if params[:destroy] && @vacancy.destroy
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
end

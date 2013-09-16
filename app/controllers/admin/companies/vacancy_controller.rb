# encoding: utf-8
class Admin::Companies::VacancyController < ApplicationController
  layout "admin"

  http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"

  skip_before_filter :require_login
  before_filter :find_vacancy, :only => [:edit, :update, :find_company, :reject, :destroy, :published, :find_category_list, :update_publicated]
  before_filter :find_company, :only => [:edit, :update, :send_letter_for_employer]
  after_filter  :published, :only => [:update]
  after_filter  :hot, :only => :update
  after_filter  :reject, :only => :update
  before_filter :destroy, :only => :update
  before_filter :find_category_list, :only => [:edit]
  after_filter :update_publicated, :only => [:published, :hot, :update]
  
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
      loop do 
        vacancies = Vacancy.where(state: "hot").order("publicated_at desc")
        vacancy = vacancies.last
        vacancy.approve_published && vacancy.update_attribute(:publicated_at, Time.now)
        break if vacancies.count == 4
      end
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

  def find_category_list
    @category = Category.where(:scope_id => [@vacancy.company.scope.id, 12])
  end

  def update_publicated
    @vacancy.update_attribute(:publicated_at, Time.now)
  end
end

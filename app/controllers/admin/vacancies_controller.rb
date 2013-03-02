class Admin::VacanciesController < ApplicationController
  layout "admin"
  before_filter :find_vacancy, :only => [:edit, :update]
  
  def index
    @vacancies = Vacancy.where(:state => ["pending", "wait_company"])
  end
  
  # FIXME: refactoring, проверить используются action edit and update?

  def edit
  end
  
  def update 
    respond_to do |format|
      if @vacancy.update_attributes(params[:vacancy])
  			format.html { redirect_to admin_vacancies_url, notes: "Edit save" }
        format.json { render :json => @vacancy }
      else
        format.html { render :action => "edit", notes: "Error" }
        format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected 
  
  def find_vacancy
    @vacancy = Vacancy.find(params[:id])
  end

end

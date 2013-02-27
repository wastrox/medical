class Admin::Companies::VacancyController < ApplicationController
  layout "admin"
  before_filter :find_vacancy, :only => [:edit, :update, :find_company]
  before_filter :find_company, :only => [:edit, :update]
    
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
  
  protected 
  
  def find_company
    @company = @vacancy.company
  end
  
  def find_vacancy
    @vacancy = Vacancy.find(params[:id])
  end
  
end

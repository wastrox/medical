class Admin::Companies::ProfileController < ApplicationController
  layout "admin"
  before_filter :company_find, :only => [:edit, :update, :destroy, :vacancies, :reject]

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
end

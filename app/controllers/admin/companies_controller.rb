class Admin::CompaniesController < ApplicationController
  layout "admin"
  before_filter :company_find, :only => [:edit, :update]
  
  def index
    @companies = Company.all
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
  
  protected
  
  def company_find
    @company = Company.find(params[:id])
  end
  
end

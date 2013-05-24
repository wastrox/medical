class Admin::CompaniesController < ApplicationController
  layout "admin"

  http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"
  
  skip_before_filter :require_login
  before_filter :company_find, :only => [:edit, :update]
  
  def index
    @companies = Company.where("state = ?", "pending")
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

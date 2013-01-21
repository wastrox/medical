class Employer::ProfileCompaniesController < ApplicationController
 layout "profile_company"	

	def new
	  @company = Company.new
	  @company.company_contacts.build
	end
	
	def create
	  @company = Company.new(params[:company])
	  
	  # => FIXME: DRY --- Присвоим компании определенного работодателя ---
	  
	  @employer = Employer.find_by_salt(cookies[:salt])
 	  @company.employer = @employer
	  # ----------------------------------------------------
	  respond_to do |format|
      if @company.save
         format.html { redirect_to proc { edit_employer_profile_company_url(@company)}}
         format.json { render :json => @company, :status => :created, :location => @company }
      else
         format.html { render :action => "new" }
         format.json { render :json => @company.errors, :status => :unprocessable_entity }
      end
    end
	end
	
	def edit
	  @company = Company.find(params[:id])
	end
	
  def update
    @company = Company.find(params[:id])
    respond_to do |format|
      if @company.update_attributes(params[:company])
				format.html { redirect_to proc { edit_employer_profile_company_url(@company)} }
        format.json { render :json => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "show" }
        format.json { render :json => @company.errors, :status => :unprocessable_entity }
      end
    end
  end
end

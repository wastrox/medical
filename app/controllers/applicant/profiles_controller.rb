class Applicant::ProfilesController < ApplicationController
  def edit
    @applicant = Applicant.find_by_salt(cookies[:salt])
    @profile = @applicant.profile
  end
  def update
    respond_to do |format|
     @profile = Profile.find(params[:id])
      if @profile.update_attributes(params[:profile])
				format.html { redirect_to :controller => "profile", :action => "show" }
        format.json { render :json => @resume, :status => :created, :location => @resume }
      else
        format.html { render :action => "show" }
        format.json { render :json => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end
end

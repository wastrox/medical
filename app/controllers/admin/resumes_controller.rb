class Admin::ResumesController < ApplicationController
  layout "admin"
  before_filter :findResume, :only => [:edit, :update, :destroy]
  
  def index
    @resumes = Resume.all
  end
  
  def edit
    @applicant = @resume.applicant
    if @applicant.profile?
      @profile = @applicant.profile
    else
      @profile = Profile.new
    end
    #@resume.build_profile
    #@resume.experiences.build
    #@resume.educations.build
  end
 
  def update
    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        format.html { redirect_to :controller => "admin/resumes", :action => "index" }
        format.json { render :json => @resume, :status => :created, :location => @resume }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    if @resume.destroy
      redirect_to admin_resumes_url
    end
  end
  
  protected
  
  def findResume
    @resume ||= Resume.find(params[:id])
  end
end

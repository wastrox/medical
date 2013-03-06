# encoding: utf-8
class Admin::ResumesController < ApplicationController
  layout "admin"
  before_filter :findResume, :only => [:edit, :update, :destroy, :reject, :published]
  after_filter  :published, :only => :update
  
  def index
    @resumes = Resume.where("state = ?", "pending")
  end
  
  def edit
    @applicant = @resume.applicant
    if @applicant.profile?
      @profile = @applicant.profile
    else
      @profile = Profile.new
    end
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
  
  def reject
    if @resume.approve_rejected
      redirect_to admin_resumes_path
    end
  end
  
  def destroy
    if @resume.destroy
      redirect_to admin_resumes_path
    end
  end
  
  def published
    if params[:published]
      case @resume.state
        when "pending", "hot", "rejected", "deferred", "secret"
          @resume.approve_published
      end
    end
  end
  
  protected
  
  def findResume
    @resume ||= Resume.find(params[:id])
  end
end

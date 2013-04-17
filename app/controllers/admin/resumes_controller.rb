# encoding: utf-8
class Admin::ResumesController < ApplicationController
  layout "admin"

  skip_before_filter :require_login
  before_filter :findResume, :only => [:edit, :update, :destroy, :reject, :published, :send_letter_for_applicant]
  after_filter  :send_letter_for_applicant, :only => :update
  after_filter  :published, :only => :update
  after_filter  :reject, :only => :update
  before_filter :destroy, :only => :update
  
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
  
  def published
    if params[:published]
       @resume.approve_published
    end
  end
  
  def reject
    if params[:reject] 
      @resume.approve_rejected
    end
  end
  
  def destroy
    if params[:destroy] && @resume.destroy
      send_letter_for_applicant
      redirect_to admin_resumes_path
    end
  end
  
  protected
  
  def findResume
    @resume ||= Resume.find(params[:id])
  end
  
  def send_letter_for_applicant
    unless params[:body_letter].empty? 
        @resume.applicant.send_letter_from_moderator(params[:body_letter])
    end
  end
end

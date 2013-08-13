# encoding: utf-8
class Admin::ResumesController < ApplicationController
  layout "admin"

  http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"

  skip_before_filter :require_login
  before_filter :findResume, :only => [:edit, :update, :destroy, :reject, :published, :send_letter_for_applicant, :findApplicant]
  before_filter :findApplicant, :only => [:edit, :update, :destroy, :reject, :published, :send_letter_for_applicant, :findProfile]
  before_filter :findProfile, :only => [:edit, :update, :destroy, :reject, :published, :send_letter_for_applicant]
  after_filter  :published, :only => :update
  after_filter  :reject, :only => :update
  before_filter :destroy, :only => :update
  
  def index
    @resumes = Resume.where("state = ?", "pending")
  end
  
  def edit
  end
 
  def update
    respond_to do |format|
      if @resume.valid? && @resume.update_attributes(params[:resume])
        format.html { redirect_to :controller => "admin/resumes", :action => "index" }
        format.json { render :json => @resume, :status => :created, :location => @resume }
      else
        format.html { render :controller => "admin/resumes", :action => "edit" }
        format.json { render :json => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def published
    if params[:published]
       @resume.approve_published
       Notifier.letter_to_resume_from_moderator_published(@resume.applicant).deliver
    end
  end
  
  def reject
    if params[:reject] 
      @resume.approve_rejected
      Notifier.letter_to_resume_from_moderator_reject(@resume.applicant, params[:body_letter]).deliver
    end
  end
  
  def destroy
    if params[:destroy] && @resume.destroy
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

  def findApplicant
      @applicant = @resume.applicant    
  end

  def findProfile
    if @applicant.profile?
      @profile = @applicant.profile
    else
      @profile = Profile.new
    end
  end
end

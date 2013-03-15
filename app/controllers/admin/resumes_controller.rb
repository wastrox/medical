# encoding: utf-8
class Admin::ResumesController < ApplicationController
  layout "admin"
  before_filter :findResume, :only => [:edit, :update, :destroy, :reject, :published, :send_letter_for_applicant]
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
        send_letter_for_employer unless params[:body_letter].empty? #FIXME: добавить фильтром
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
      send_letter_for_employer unless params[:body_letter].empty? #FIXME: так писать - очень хуевый тон, DRY!
      redirect_to admin_resumes_path
    end
  end
  
  def destroy
    if @resume.destroy
      send_letter_for_employer unless params[:body_letter].empty?
      redirect_to admin_resumes_path
    end
  end
  
  def published
    if params[:published]
      case @resume.state
        when "pending", "hot", "rejected", "deferred", "secret"
          @resume.approve_published
          send_letter_for_employer unless params[:body_letter].empty?
      end
    end
  end
  
  protected
  
  def findResume
    @resume ||= Resume.find(params[:id])
  end
  
  def send_letter_for_applicant
    case @resume.state
      when "pending", "published", "hot", "rejected", "deferred", "secret"
        @resume.applicant.send_letter_from_moderator(params[:body_letter])
    end
  end
end

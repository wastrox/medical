# encoding: utf-8
class Admin::ResumesController < ApplicationController
  layout "admin"
  before_filter :findResume, :only => [:edit, :update, :destroy, :reject, :submit_name_for_form]
  before_filter :submit_name_for_form, :only => :edit
  
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
  end
 
  def update
    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        @resume.approve_published unless @resume.published? #published
        format.html { redirect_to :controller => "admin/resumes", :action => "index" }
        format.json { render :json => @resume, :status => :created, :location => @resume }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  #def published
  #  if @resume.approve_published
  #    redirect_to admin_resumes_path, notes: "Резюме опубликовано"
  #  end
  #end
  
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
  
  def submit_name_for_form
    state = @resume.state
    @name = case state
              when "draft", "hot", "rejected", "pending", "secret", "deferred" then "Опубликовать"
              when "published" then "Обновить"
            end
  end
  
  protected
  
  def findResume
    @resume ||= Resume.find(params[:id])
  end
end

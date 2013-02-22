class Admin::ResumesController < ApplicationController
  layout "admin"
  before_filter :findResume, :only => [:edit, :update]
  
  def index
    @resumes = Resume.all
  end
  
  def edit
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
  
  protected
  
  def findResume
    @resume ||= Resume.find(params[:id])
  end
end

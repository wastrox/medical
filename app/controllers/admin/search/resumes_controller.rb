class Admin::Search::ResumesController < ApplicationController
  layout 'admin'
  skip_before_filter :require_login
  
  def index
    @resumes = Resume.search(params[:search])
  end
end

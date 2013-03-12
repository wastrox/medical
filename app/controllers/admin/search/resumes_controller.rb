class Admin::Search::ResumesController < ApplicationController
  layout 'admin'
  
  def index
    @resumes = Resume.search(params[:search])
  end
end

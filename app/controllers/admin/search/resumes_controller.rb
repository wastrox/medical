class Admin::Search::ResumesController < ApplicationController
  layout 'admin'
  http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"
  
  skip_before_filter :require_login
  
  def index
    @resumes = Resume.search(params[:search])
  end
end

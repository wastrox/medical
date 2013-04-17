class Admin::Search::CompaniesController < ApplicationController
  layout 'admin'
  skip_before_filter :require_login
  
  def index
    @companies = Company.search(params[:search])
  end
end

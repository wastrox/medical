class Admin::Search::CompaniesController < ApplicationController
  layout 'admin'
  
  def index
    @companies = Company.search(params[:search])
  end
end

class Admin::AccountsController < ApplicationController
  layout "admin"

  http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"

  skip_before_filter :require_login

  def index
    @accounts = Account.search(params[:search])
  end
end

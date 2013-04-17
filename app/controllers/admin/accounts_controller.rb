class Admin::AccountsController < ApplicationController
  layout "admin"

  skip_before_filter :require_login

  def index
    @accounts = Account.search(params[:search])
  end
end

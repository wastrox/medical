class Admin::AccountsController < ApplicationController
  layout "admin"

  def index
    @accounts = Account.search(params[:search])
  end
end

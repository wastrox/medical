class Admin::AccountsController < ApplicationController
  layout "admin"

  def index
    @accounts = Account.all
  end
end

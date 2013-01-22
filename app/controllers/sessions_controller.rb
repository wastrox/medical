class SessionsController < ApplicationController
  before_filter :find_account_by_email, :only =>  [:create, :require_active]
  before_filter :require_active, :only => [:create]
  def new
  end

  def create
    if @account && @account.authenticate(params[:password])
			cookies.permanent[:salt] = @account.salt
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    cookies.delete(:salt)
    redirect_to root_url, notice: "Logged out!"
  end
  
  protected
  
  def find_account_by_email
    @account = Account.find_by_email(params[:email])
  end
  
  def require_active
    unless @account.active? 
      redirect_to :controller => :confirmation, :action => :index 
    end
  end
  
end

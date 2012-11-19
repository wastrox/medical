class SessionsController < ApplicationController
  def new
  end

  def create
    account = Account.find_by_email(params[:email])
		if account && account.active == false
			redirect_to :controller => :confirmation, :action => :index
    elsif account && account.authenticate(params[:password])
			cookies.permanent[:salt] = account.salt
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
end

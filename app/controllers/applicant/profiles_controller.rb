#encoding: utf-8  
class Applicant::ProfilesController < ApplicationController
 layout "profile_applicant"
 before_filter :require_account_type_applicant, :check_account_type
 before_filter :find_applicant, :only => [:edit, :update]
 before_filter :find_profile, :only => [:edit, :update]

  def edit
    @title = "Профиль #{@profile.lastname} #{@profile.firstname} #{@profile.surename}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end
  
  def update
    respond_to do |format|
      if @profile.update_attributes(params[:profile])
				format.html { redirect_to :controller => "applicant/profiles", :action => "edit" }
        format.json { render :json => @resume, :status => :created, :location => @resume }
      else
        flash[:notice] = "Все поля отмеченные красным цветом - обязательны для заполнения"
        format.html { render :action => "edit" }
        format.json { render :json => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end

  protected

  def find_applicant
    @applicant = Applicant.find_by_salt(cookies[:salt])
  end

  def find_profile
    @profile = @applicant.profile
  end
end

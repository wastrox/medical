#encoding: utf-8
class Employer::MyResumesController < ApplicationController
 layout "profile_company"	

 before_filter :find_employer, :only => [ :index, :destroy_resume_respond ]
 before_filter :find_resumes, :only => [ :index, :destroy_resume_respond ]

  def index
    @title = "Избранные резюме: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end

  def destroy_resume_respond
  	resume_respond = ResumeRespond.find(params[:id])
    if resume_respond.employer == @employer
      if resume_respond.destroy
        redirect_to employer_my_resumes_index_url
      end
    end
  end

  protected

  def find_employer
    @employer = Employer.find_by_salt(cookies[:salt])
  end

  def find_resumes
    @resumes = @employer.resume_responds    
  end
end

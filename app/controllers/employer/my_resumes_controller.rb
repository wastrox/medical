#encoding: utf-8
class Employer::MyResumesController < ApplicationController
 layout "profile_company"	

  def index
  	@employer = Employer.find_by_salt(cookies[:salt])
  	@resumes = @employer.resume_responds
    @title = "Избранные резюме: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end

  def destroy_resume_respond
  	resume_respond = ResumeRespond.find(params[:id])
    if resume_respond.destroy
      redirect_to employer_my_resumes_index_url
    end
  end

end

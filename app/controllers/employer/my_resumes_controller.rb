class Employer::MyResumesController < ApplicationController
 layout "profile_company"	

  def index
  	@employer = Employer.find_by_salt(cookies[:salt])
  	@resumes = @employer.resume_responds
  end

end

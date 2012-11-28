class Applicant::ResumesController < ApplicationController
	before_filter :findApplicant, :resumeExists?, :only => [:new, :create] # resumeExists? проверка резюме у applicant, если есть -->> /applicant/resume/show
  before_filter :initResume, :only => [:new, :create, :update]
  before_filter :findResume, :only => [:show, :destroy]

  def new
    @resume.experiences.build
    @resume.educations.build
    @resume.languages.build
    @resume.pc_skills.build
  end
	
	def create
		@resume.applicant = @applicant
		respond_to do |format|
      if @resume.save 
        format.html { redirect_to :controller => 'resumes', :action => 'show', :id => @resume.id }
        format.json { render :json => @resume, :status => :created, :location => @resume }
      else
        format.html { render :action => "new" }
        format.json { render :json => @resume.errors, :status => :unprocessable_entity }
      end
    end
	end

  def show
  end
 
  def update
	  respond_to do |format|
      if @resume.update_attributes(params[:resume])
				format.html { redirect_to :controller => "resumes", :action => "show" }
        format.json { render :json => @resume, :status => :created, :location => @resume }
      else
        format.html { render :action => "new" }
        format.json { render :json => @resume.errors, :status => :unprocessable_entity }
      end
    end
	end

	def destroy
		if @resume.destroy
			 redirect_to "/"
		end
	end

	protected
		
	def initResume
		@resume = Resume.new(params[:resume])
		@resume ||= Resume.new
  end

  def findResume
    @resume ||= Resume.find(params[:id]) 
  end

	def initProfile
    @profile = Profile.new(params[:profile])
    @profile ||= Profile.new
	end
	
	def findProfile
		@profile = Profile.find(params[:id])	
	end

	def findApplicant
		@applicant = Applicant.find_by_salt(cookies[:salt])
	end
	
	def	resumeExists?
		if @applicant.resume?
			resumeId = @applicant.resume.id
			redirect_to applicant_resume_path(resumeId) 
    end
	end
end

class Applicant::ResumesController < ApplicationController
	before_filter :findApplicant,  :only => [:new, :create, :show, :edit] 
  before_filter :resumeExists?, :only => [:new, :create]  # resumeExists? проверка резюме у applicant, если есть -->> /applicant/resume/show
  before_filter :initResume, :only => [:new, :create]
  before_filter :findResume, :only => [:show, :destroy, :edit, :update]
	before_filter :findProfile, :only => [:show, :edit]

  def new
		if @applicant.profile?
			 @profile = @applicant.profile
		else
			 @profile = Profile.new
    end
		@resume.build_profile
    @resume.experiences.build
    @resume.educations.build
    @resume.languages.build
    @resume.pc_skills.build
  end
	
	def create

		@resume.applicant = @applicant #когда создается резюме, ему присваивается какому Соискателю принадлежит, так реализовано потому, что нельзя написать Applicant.new и т.д... Applicant наследуется от Account, а аккаунт уже есть в базе. 

		if @applicant.profile? #Это условие необходимо т.к. при удалении резюме, остается Profile, который связан с Applicant. Если у Соискателя есть профиль, его свойство resume_id меняется на актуальное resume_id.
			@resume.profile = @applicant.profile
			@resume.profile.update_attributes(params[:resume][:profile_attributes])
		elsif
    	@resume.profile.applicant = @applicant
		end

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
		@fullName = "#{@profile.lastname} #{@profile.firstname} #{@profile.surename}"
  end
	
	def edit
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

	def findApplicant
		@applicant = Applicant.find_by_salt(cookies[:salt])
	end
	
	def	resumeExists?
		if @applicant.resume?
			resumeId = @applicant.resume.id
			redirect_to applicant_resume_path(resumeId) 
    end
	end

	def findProfile
		@profile = @applicant.profile
	end
end

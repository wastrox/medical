class Applicant::ResumesController < ApplicationController
 layout "profile_applicant"
  before_filter :require_account_type_applicant, :check_account_type
  before_filter :findApplicant, :only => [:index, :new, :create, :show, :edit, :update, :add_vacancy_responded]
  before_filter :resumeExists?, :only => [:new, :create] # resumeExists? проверка резюме у applicant, если есть -->> /applicant/resume/show
  before_filter :initResume, :only => [:new, :create]
  before_filter :findResume, :only => [:show, :destroy, :edit, :update, :defer]
  before_filter :findProfile, :only => [:show, :edit, :update] #присваиваем @profile найденный профиль пользователя ( def findApplicant --> @applicant ), чтобы заполнить поля value in partial _profile_fields.html

  def index
    @resume = @applicant.resume
    @fullName = "#{@resume.profile.lastname} #{@resume.profile.firstname} #{@resume.profile.surename}"
  end

  def new
    # FIXME: условие для корректного отображения input value => @profile.name. Повторяется в методе create.
    
    if @applicant.profile?
      @profile = @applicant.profile
    else
      @profile = Profile.new
    end
    
    # --- *** ---
    @resume.build_profile
    #@resume.experiences.build
    #@resume.educations.build
  end

  def create
    # FIXME: DRY, повторяется в методе new

    if @applicant.profile?
       @profile = @applicant.profile
    else
       @profile = Profile.new
    end
    
    # --- *** ---

    if @resume.valid?
      @resume.applicant = @applicant #когда создается резюме, ему присваивается какому Соискателю принадлежит, так реализовано потому, что нельзя написать Applicant.new и т.д... Applicant наследуется от Account, а аккаунт уже есть в базе.
      
      if @applicant.profile? #Это условие необходимо т.к. при удалении резюме, остается Profile, который связан с Applicant. Если у Соискателя есть профиль, его свойство resume_id меняется на актуальное resume_id.
        @resume.profile = @applicant.profile
        @resume.profile.update_attributes(params[:resume][:profile_attributes])
      elsif
        @resume.profile.applicant = @applicant
      end
    end

    respond_to do |format|
      if @resume.save
         @resume.request
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
        @resume.edit
        format.html { redirect_to :controller => "resumes", :action => "show" }
        format.json { render :json => @resume, :status => :created, :location => @resume }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    if @resume.destroy
      redirect_to edit_applicant_profile_path(@resume.profile)
    end
  end

  def defer
    @resume.defer
    redirect_to applicant_resume_path(@resume)
  end

  def add_vacancy_responded 
    vacancy_respond = VacancyRespond.new
    vacancy_respond.applicant_id = @applicant.id
    vacancy_respond.vacancy_id = params[:vacancy]
    vacancy_respond.respond_date = Time.now
    vacancy_respond.save
    redirect_to :controller => '/search', :action => 'vacancy', :id => params[:vacancy]
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
      redirect_to applicant_resume_path(@applicant.resume.id)
    end
  end

  def findProfile
    @profile = @applicant.profile
  end
end

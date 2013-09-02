# encoding: utf-8
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
    @title = "Резюме #{@resume.position}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end

  def new
    # FIXME: условие для корректного отображения input value => @profile.name. Повторяется в методе create.
    if @applicant.profile?
      @profile = @applicant.profile
    else
      @profile = Profile.new
    end
    
    @resume.build_profile
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
        Notifier.letter_to_admin("Новое РЕЗЮМЕ #{@resume.position} на модерации", "Проверьте резюме в админке.").deliver

        format.html { redirect_to :controller => 'resumes', :action => 'show', :id => @resume.id }
        format.json { render :json => @resume, :status => :created, :location => @resume }
      else
        flash[:notice] = "Все поля отмеченные красным цветом - обязательны для заполнения"
        format.html { render :action => "new" }
        format.json { render :json => @resume.errors, :status => :unprocessable_entity }
      end
    end
end

  def show
    @fullName = "#{@profile.lastname} #{@profile.firstname} #{@profile.surename}"
    @title = "Резюме #{@resume.position}: работа в медицине. Сайт трудоустройства medical.netbee.ua"

    respond_to do |format|
      format.html
      format.pdf {
        pdf_usage
      }
    end
  end

  def edit
    @title = "Редактировать резюме #{@resume.position}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end
 
  def update
    respond_to do |format|
      if @resume.update_attributes(params[:resume])

        @resume.edit
        Notifier.letter_to_admin("РЕЗЮМЕ #{@resume.position} редактировалось и ожидает модерации", "Проверьте резюме в админке.").deliver

        format.html { redirect_to :controller => "resumes", :action => "show" }
        format.json { render :json => @resume, :status => :created, :location => @resume }
      else
        flash[:notice] = "Все поля отмеченные красным цветом - обязательны для заполнения"
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
    vacancy_respond = VacancyRespond.new(:applicant_id => @applicant.id, :vacancy_id => params[:vacancy_id], :respond_date => Time.now, :vacancy_name => params[:vacancy_name])    

    respond_to do |format|
      if vacancy_respond.save
        vacancy = Vacancy.find(vacancy_respond.vacancy_id)
        company = vacancy.company
        employer = company.employer

        employer.send_vacancy_respond(vacancy, @applicant)

        flash[:notice] = "Работодателю было выслано ваше резюме. Вакансия #{vacancy.name} добавлена в Избранные ваканси."
        format.html { redirect_to :controller => '/search', :action => 'vacancy', :id => vacancy.to_param }
      else
        format.html { redirect_to :controller => '/search', :action => 'vacancy', :id => vacancy.to_param }
      end
    end
  end

  def destroy_vacancy_respond
    vacancy_respond = VacancyRespond.find(params[:id])
    if vacancy_respond.destroy
      redirect_to applicant_my_vacancies_index_url
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
      redirect_to applicant_resume_path(@applicant.resume.id)
    end
  end

  def findProfile
    @profile = @applicant.profile
  end

  def pdf_usage
    html = render_to_string(:layout => "pdf.html.erb" , :action => "show.html.erb", :formats => [:html], :handler => [:erb])
    kit = PDFKit.new(html)
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/pdf.css"
    nameApplicant = Russian.translit("#{@profile.lastname}_#{@profile.firstname}_#{@resume.position}")
    send_data(kit.to_pdf, :filename => nameApplicant, :type => 'pdf')
    return # to avoid double render call
  end
end

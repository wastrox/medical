# coding: utf-8
class Employer::ProfileCompaniesController < ApplicationController
 layout "profile_company"	
 before_filter :init_company, :only => [:new, :create]
 before_filter :find_company, :only => [:edit, :update, :show]
 before_filter :find_employer, :only => [:index, :create, :show, :add_resume_responded]
 before_filter :require_account_type_employer, :check_account_type

  def index
    @company = @employer.company
    @title = "Компания #{@company.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end

	def new
	  @company.company_contacts.build
	end
	
	def create  
 	  @company.employer = @employer
	  respond_to do |format|
      if @company.save

         @company.request # FIXME: заменить на фильтр 
         Notifier.letter_to_admin("Новая КОМПАНИЯ #{@company.name}, ожидает проверки модератором", "Проверьте компанию в админке.").deliver

         format.html { redirect_to proc { employer_profile_company_path(@company)}, notes: "Компания зарегестрирована"}
         format.json { render :json => @company, :status => :created, :location => @company }
      else
         format.html { render :action => "new" }
         format.json { render :json => @company.errors, :status => :unprocessable_entity }
      end
    end
	end

  def show
    @contacts = @company.company_contacts
    @title = "Компания #{@company.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end
	
	def edit
    @title = "Компания #{@company.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
	end
	
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])

        @company.edit # FIXME: заменить на фильтр
        Notifier.letter_to_admin("КОМПАНИЯ #{@company.name} редактировалась, ожидает проверки модератором", "Проверьте компанию в админке.").deliver

        # ---------------------------------------------------------------
        # FIXME: заменить фильторм
        # когда компания была отменена модератором, все вакансии, ожидавшие изменения в профиле компании
        # снова отправляются на модерацию
        vacancies = @company.vacancies.where("state = ?", "wait_company")
        vacancies.each {|v| v.request}
        # ---------------------------------------------------------------
				format.html { render :action => "show", notes: "Edit save" }
        format.json { render :json => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "edit", notes: "Error" }
        format.json { render :json => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_resume_responded 
    resume_respond = ResumeRespond.new(:employer_id => @employer.id, :resume_id => params[:resume_id], :respond_date => Time.now)    

    respond_to do |format| 
      if resume_respond.save
        resume = Resume.find(resume_respond.resume_id)
        flash[:notice] = "Резюме #{resume.position} добавлено в Избранные резюме."
        format.html { redirect_to :controller => '/search', :action => 'resume', :id => resume.to_param }
      else
        format.html { redirect_to :controller => '/search', :action => 'resume', :id => resume.to_param }
      end
    end
  end
  
  protected
  
  def init_company
    @company = Company.new(params[:company])
    @company ||= Company.new
  end
  
  def find_company
    @company = Company.find(params[:id])
  end
  
  def find_employer
    @employer = Employer.find_by_salt(cookies[:salt])
  end

end

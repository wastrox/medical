# coding: utf-8
# FIXME: DRY
class Employer::VacanciesController < ApplicationController
  layout "profile_company"	
  before_filter :require_account_type_employer, :check_account_type
  before_filter :find_employer, :only => [:find_company, :index, :new, :create]
  before_filter :find_company, :only => [:index, :new, :create, :find_category_list]
  before_filter :init_vacancy, :only => [:new, :create, :check_vacancy_valid_and_save_in_draft]
  before_filter :find_vacancy, :only => [:show, :edit, :update, :destroy, :check_vacancy_valid_and_update_in_draft, :defer, :find_category_list, :update_publicated]
  before_filter :find_contacts, :only => [:new, :edit, :create, :update]
  before_filter :find_category_list, :only => [:new, :edit, :create, :update]
  
  def index
    @vacancies = @company.vacancies
    @title = "Список вакансий: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end
  
  def new
    @title = "Создание вакансии: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end
  
  def create 
    if params[:save]
	    respond_to do |format|  
        if @vacancy.save

          @vacancy.request # FIXME: заменить на filter
          Notifier.letter_to_admin("Создана ВАКАНСИЯ #{@vacancy.name}, ожидает проверки модератором", "Проверьте вакансию в админке.").deliver

          format.html { redirect_to employer_vacancies_url, notes: "Вакансия создана"}
          format.json { render :json => @vacancy, :status => :created, :location => @company }
        else
          flash[:notice] = "Все поля отмеченные красным цветом - обязательны для заполнения"
          format.html { render :action => "new" }
          format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @vacancy.save(:validate => false)
          @vacancy.drafting # FIXME: заменить на filter, повторение кода в action Update!
          format.html { redirect_to employer_vacancies_url, notes: "Вакансия сохранена как черновик"}
          format.json { render :json => @vacancy, :status => :created, :location => @company }
        else
          format.html { render :action => "new" }
          format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  
  def show
    @title = "Вакансия #{@vacancy.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end
  
  def edit
    @title = "Редактирование вакансии #{@vacancy.name}: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end
  
  def update 
    if params[:save]
      respond_to do |format|
        if @vacancy.update_attributes(params[:vacancy])

          @vacancy.edit #FIXME: заменить на filter
          Notifier.letter_to_admin("ВАКАНСИЯ #{@vacancy.name} редактировалась, ожидает проверки модератором", "Проверьте вакансию в админке.").deliver

  			  format.html { redirect_to employer_vacancies_url, notes: "Edit save" }
          format.json { render :json => @vacancy }
        else
          flash[:notice] = "Все поля отмеченные красным цветом - обязательны для заполнения"
          format.html { render :action => "edit" }
          format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @vacancy.attributes = params[:vacancy]
        if @vacancy.save(:validate => false)
          @vacancy.drafting #FIXME: заменить на filter
  			  format.html { redirect_to employer_vacancies_url, notes: "Сохранен как черновик" }
          format.json { render :json => @vacancy }
        else
          format.html { render :action => "edit", notes: "Error" }
          format.json { render :json => @vacancy.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  
  def destroy
    if @vacancy.destroy
      flash[:notes] = "Deleted successfully"
    else
      flash[:notes] = "Error" 
    end
    redirect_to employer_vacancies_url
  end

  def update_publicated
    if @vacancy.update_attribute(:publicated_at, Time.now) && @vacancy.approve_published
      account = @vacancy.company.employer
      date = Time.now.utc
      subject = "Вакансия #{@vacancy.name} была обновлена на сайте www.medical.netbee.ua"
      Notifier.letter_published_update(account, subject, @vacancy, date).deliver
      redirect_to employer_vacancies_url
    end
  end

  def defer
    @vacancy.defer
    redirect_to employer_vacancies_url
  end
  
  protected
  
  def find_employer
    @employer = Employer.find_by_salt(cookies[:salt])
  end
  
  def find_company
    @company = @employer.company
  end
  
  def init_vacancy
    @vacancy = @company.vacancies.new(params[:vacancy])
    @vacancy ||= @company.vacancies.new
  end
  
  def find_vacancy
    @vacancy = Vacancy.find(params[:id])
  end
  
  def find_contacts
    @contacts = CompanyContact.where("company_id = ?", current_user.company.id )
  end

  def find_category_list
    @category = Category.where(:scope_id => [@vacancy.company.scope.id, 12])
  end
end

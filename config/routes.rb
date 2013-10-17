Medical::Application.routes.draw do
  root :to => 'startpage#index'
  
  get "categories/new"
  get "categories/edit"
  get "scope/index"
  get "scope/edit"
  get "scope/new"
  get "contacts/index"
  get "personal_data/index"
  get "about", to: "about#index"
  get "vacancies/index"

  resources "news", :only => [:index, :show]
  
  get "vacancy/index"
  get "vacancy/edit"
  get "resumes/index"
  get "confirmation/index"
  
  get 'signup', to: 'accounts#new', as: 'signup'
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
  get "recover", to: "accounts#recover", as: "recover"
  get "reactive", to: "accounts#reactive", as: "reactive"
  get "email_recovery", to: "accounts#email_recovery", as: "email_recovery"
  get "active_recovery", to: "accounts#active_recovery", as: "active_recovery"

  match "/search", to: "search#index"

  match "vacancy/*scope/*category/:id", to: "search#vacancy"
  match "vacancy/*scope/*category/", to: "search#category"
  match "vacancy/*scope", to: "search#scope"

  match "search/resume/:id", to: "search#resume"
  match "company/:id", to: "search#company"

  match "companies", to: "search#all_company"
  match "search/company" => redirect("/search/companies")

	match "confirmation" => "confirmation#index"
  match "confirmation/account_type" => "confirmation#account_type"	
	match 'activate(/:token)' => 'accounts#activate', :as => :activate_account
	match 'confirmation/applicant/(/:token)' => 'confirmation#applicant'
	match 'confirmation/employer/(/:token)' => 'confirmation#employer'
	
  resources :accounts

  match "accounts/edit(/:token)" => 'accounts#edit'
  match "accounts/update(/:token)" => 'accounts#update'

  get "sessions/new/", to: "sessions#new"
  resources :sessions, :only => [:create]
	resources :applicants
	
  namespace :applicant, :as => 'applicant' do	
    get "my_vacancies/index"
    match "resumes/defer", to: "resumes#defer"
    match "resumes/destroy_vacancy_respond/:id" => "resumes#destroy_vacancy_respond" 
    match "resumes/add_vacancy_responded", to: "resumes#add_vacancy_responded"
    
		resources :resumes
		resources :profiles, :only => [:edit, :update]
	end

	namespace :employer, :as => 'employer' do
    get "my_resumes/index"
    match "my_resumes/destroy_resume_respond/:id" => "my_resumes#destroy_resume_respond" 
    match "profile_companies/add_resume_responded", to: "profile_companies#add_resume_responded"
		match 'vacancies/create_draft' => 'vacancies#create_draft'
    match 'vacancies/defer/:id' => 'vacancies#defer'
    match 'vacancies/update_publicated/:id' => 'vacancies#update_publicated'

    resources :profile_companies #, :only => [:index, :edit, :update, :new, :create, :show]
    resources :vacancies
	end
	
	match "/admin" => redirect("/admin/companies")
	
	namespace :admin do
    get 'companies', to: 'companies#index'
    get "search", to: "search#index"

    match "search/choice_user_for_admin/:token", to: 'search#choice_user_for_admin'
    match 'resumes/published/(:id)' => 'resumes#published'
    match 'resumes/reject/(:id)' => 'resumes#reject'
    match 'search/destroy_account_respond/:id' => "search#destroy_account_respond"
    
    namespace :companies do
      resources :profile
      resources :vacancy  
      match "profile/:id/vacancies" => "profile#vacancies"
      match 'profile/reject/(:id)' => 'profile#reject', :via => [:get]
      match 'profile/vacancies/reject/(:id)' => 'vacancy#reject'
    end

    namespace :seo do
      resources :scope
      resources :categories
    end

    resources :vacancies
    resources :resumes
    resources :tasks
    resources :articles
    match 'articles/archive/:id' => "articles#archive", :as => "articles_archive"
	end
end

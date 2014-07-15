Medical::Application.routes.draw do
  root :to => 'startpage#index'

  # Devise gem --> authentication <-- http://rdoc.info/github/plataformatec/devise
  devise_for :accounts, path: "/", controllers: { registrations: "devise/registrations", confirmations: "devise/confirmations" }, 
             path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }

  devise_scope :accounts do
    get "login", to: "devise/sessions#new", as: :login
    get "logout", to: "devise/sessions#destroy", as: :logout
    get "signup", to: "devise/registrations#new", as: :signup
  end
 
  get '/confirmation/type', controller: "confirmation", action: "type", as: :confirmation_account_type

  # -----------------------------------------------------------------------------------------------------------------------------

  as :accounts do
      patch '/confirmation' => 'devise/confirmations#update', :via => :patch, :as => :update_account_confirmation
  end

  get "/admin" => redirect("/admin/companies")

  namespace :admin do
    get 'companies', to: 'companies#index'
    get "search", to: "search#index"

    get "search/choice_user_for_admin/:token", to: 'search#choice_user_for_admin'
    get 'resumes/published/(:id)' => 'resumes#published'
    get 'resumes/reject/(:id)' => 'resumes#reject'
    get 'search/destroy_account_respond/:id' => "search#destroy_account_respond"

    namespace :companies do
      resources :profile
      resources :vacancy
      get "profile/:id/vacancies" => "profile#vacancies"
      get 'profile/reject/(:id)' => 'profile#reject'
      get 'profile/vacancies/reject/(:id)' => 'vacancy#reject'
    end

    namespace :seo do
      resources :scope
      resources :categories
    end

    resources :vacancies
    resources :resumes
    resources :tasks
    resources :articles
    get 'articles/archive/:id' => "articles#archive", :as => "articles_archive"
  end

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
  # get "confirmation/index"
  # get "confirmation/yes", to: "confirmation#yes"
  # get "confirmation/no", to: "confirmation#no"
  # get "confirmation/deliver_mail", to: "confirmation#deliver_mail"

  # get 'signup', to: 'accounts#new', as: 'signup'
  # get "login", to: "sessions#new", as: "login"
  # get "logout", to: "sessions#destroy", as: "logout"
  get "recover", to: "accounts#recover", as: "recover"
  get "reactive", to: "accounts#reactive", as: "reactive"
  get "email_recovery", to: "accounts#email_recovery", as: "email_recovery"
  get "active_recovery", to: "accounts#active_recovery", as: "active_recovery"

  match "/search", to: "search#index", via: [ :get, :post ]

  get "*city/vacancy/*scope/*category/:id", to: "search#vacancy"
  get "(*city)/vacancy/*scope/*category/", to: "search#category"
  get "(*city)/vacancy/*scope", to: "search#scope"
  get "*city/vacancy/", to: "search#city", as: :city_vacancy

  get "search/resume/:id", to: "search#resume"
  get "company/:id", to: "search#company"

  get "companies", to: "search#all_company"
  get "search/company" => redirect("/search/companies")

  # get "confirmation" => "confirmation#index"
  # get "confirmation/account_type" => "confirmation#account_type"
  # get 'activate/:token' => 'accounts#activate', :as => :activate_account
  get 'confirmation/applicant/(/:token)' => 'confirmation#applicant'
  get 'confirmation/employer/(/:token)' => 'confirmation#employer'

  # get "accounts/edit/:token" => 'accounts#edit'
  # get "accounts/update/:token" => 'accounts#update', :as => "change_password"

  # get "sessions/new/", to: "sessions#new"
  # resources :sessions, :only => [:create]
  
  resources :applicants

  namespace :applicant, :as => 'applicant' do
    get "my_vacancies/index"
    get "resumes/defer", to: "resumes#defer"
    get "resumes/destroy_vacancy_respond/:id" => "resumes#destroy_vacancy_respond"
    get "resumes/add_vacancy_responded", to: "resumes#add_vacancy_responded"

resources :resumes
resources :profiles, :only => [:edit, :update]
end

namespace :employer, :as => 'employer' do
    get "my_resumes/index"
    get "my_resumes/destroy_resume_respond/:id" => "my_resumes#destroy_resume_respond"
    get "profile_companies/add_resume_responded", to: "profile_companies#add_resume_responded"
get 'vacancies/create_draft' => 'vacancies#create_draft'
    get 'vacancies/defer/:id' => 'vacancies#defer'
    get 'vacancies/update_publicated/:id' => 'vacancies#update_publicated'

    resources :profile_companies #, :only => [:index, :edit, :update, :new, :create, :show]
    resources :vacancies
end

  get 'sitemap', to: "sitemap#index"
end

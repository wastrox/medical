Medical::Application.routes.draw do
  get "about", to: "about#index"

  get "vacancies/index"
  
	root :to => 'startpage#index'
  get "vacancy/index"
  get "vacancy/edit"
  get "resumes/index"
  get "confirmation/index"
  get 'signup', to: 'accounts#new', as: 'signup'
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
  
  get "search", to: "search#index"
  match "search/vacancy/:id", to: "search#vacancy"
  match "search/resume/:id", to: "search#resume"
  match "search/company/:id", to: "search#company"

	match "confirmation" => "confirmation#index"
  match "confirmation/account_type" => "confirmation#account_type"	
	match 'activate(/:token)' => 'accounts#activate', :as => :activate_account
	match 'confirmation/applicant/(/:token)' => 'confirmation#applicant'
	match 'confirmation/employer/(/:token)' => 'confirmation#employer'
	
  resources :accounts
  resources :sessions
	resources :applicants
	
  namespace :applicant, :as => 'applicant' do	
    get "my_vacancies/index"
    match "resumes/defer", to: "resumes#defer"
    match "resumes/add_vacancy_responded", to: "resumes#add_vacancy_responded"
    
		resources :resumes
		resources :profiles, :only => [:edit, :update]
	end

	namespace :employer, :as => 'employer' do
		resources :profile_companies, :only => [:index, :edit, :update, :new, :create, :show]
		resources :vacancies
		match 'vacancies/create_draft' => 'vacancies#create_draft'
    match 'vacancies/defer/:id' => 'vacancies#defer'
	end
	
	match "/admin" => redirect("/admin/companies")
	
	namespace :admin do
    get 'companies', to: 'companies#index'
    get "search", to: "search#index"
    
    match 'resumes/published/(:id)' => 'resumes#published'
    match 'resumes/reject/(:id)' => 'resumes#reject'
    
    namespace :companies do
      resources :profile
      resources :vacancy  
      match "profile/:id/vacancies" => "profile#vacancies"
      match 'profile/reject/(:id)' => 'profile#reject', :via => [:get]
      match 'profile/vacancies/reject/(:id)' => 'vacancy#reject'
    end
    resources :vacancies
    resources :resumes
	end
end

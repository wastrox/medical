Medical::Application.routes.draw do
	root :to => 'startpage#index'
  get "vacancy/index"
  get "vacancy/edit"
  get "resumes/index"
  get "confirmation/index"
  get 'signup', to: 'accounts#new', as: 'signup'
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
	get "search/applicant", to: "search#applicant"
	get "search/vacancy", to: "search#vacancy"
	get "search/vacancy/:id", to: "search#show"

	match "confirmation" => "confirmation#index"
  match "confirmation/account_type" => "confirmation#account_type"	
	match 'activate(/:token)' => 'accounts#activate', :as => :activate_account
	match 'confirmation/applicant/(/:token)' => 'confirmation#applicant'
	match 'confirmation/employer/(/:token)' => 'confirmation#employer'
	
  resources :accounts
  resources :sessions
	resources :applicants
	
  namespace :applicant, :as => 'applicant' do	
		resources :resumes #, :as => 'resume' #, :path => 'resume'
		resources :profiles, :only => [:edit, :update]
	end

	namespace :employer, :as => 'employer' do
		resources :profile_companies, :only => [:edit, :update, :new, :create]
		resources :vacancies
		match 'vacancies/create_draft' => 'vacancies#create_draft'
	end
	
	namespace :admin do
    root :to => 'admin/companies#index'
    get 'companies', to: 'companies#index'
    match 'resumes/published/(:id)' => 'resumes#published'
    match 'resumes/reject/(:id)' => 'resumes#reject'
    
    namespace :companies do
      resources :profile
      resources :vacancy  
      match "profile/:id/vacancies" => "profile#vacancies"
      match 'profile/reject/(:id)' => 'profile#reject'
      match 'profile/vacancies/reject/(:id)' => 'vacancy#reject'
    end
    resources :vacancies
    resources :resumes
    resources :accounts, :only => :index
	end
end

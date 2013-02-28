Medical::Application.routes.draw do
  get "vacancy/index"

  get "vacancy/edit"

  get "resumes/index"

	match "testIndex" => "startpage#testIndex" #Тестовая страница для верстки главной страницы, прототипа
	match "resume" => "startpage#resume" #Тестовое резюме, переверстанное в div
  
  get "confirmation/index"

	root :to => 'startpage#index'
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
	end
	
	namespace :admin do
    root :to => 'admin/companies#index'
    get 'companies', to: 'companies#index'
    namespace :companies do
      match "profile/:id/vacancies", to: "profile#vacancies"
      match 'profile/reject/(:id)' => 'profile#reject'
      resources :profile
      resources :vacancy
    end
    resources :vacancies
    resources :resumes
	end
end

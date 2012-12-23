Medical::Application.routes.draw do
	match "testIndex" => "startpage#testIndex" #Тестовая страница для верстки главной страницы, прототипа
	match "resume" => "startpage#resume" #Тестовое резюме, переверстанное в div

  get "confirmation/index"

	root :to => 'startpage#index'
  get 'signup', to: 'accounts#new', as: 'signup'
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
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
	end

end

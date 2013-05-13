class Vacancy < ActiveRecord::Base
  attr_accessible :category, :city, :description, :experiences, :name, :salary, :timetable, :timetable_other, :company_contact_id

  belongs_to :company
  belongs_to :company_contact

  has_many :vacancy_responds
  has_many :applicants, :through => :vacancy_responds

  validates_presence_of :category, :city, :description, :experiences, :name, :salary, :timetable, :company_contact_id

	define_index do
		indexes name 
    indexes created_at, sortable: true
		indexes city
		set_property :delta => :delayed
		where " vacancies.state IN ('published', 'hot')" # Индексирует только опубликованные и горячие вакансии
	end
	
	state_machine :state, :initial => :draft do
    event :request do
      transition [:draft, :wait_company] => :pending
    end
    
    event :approve_published do
      transition [:pending, :deferred, :hot, :rejected] => :published
    end
    
    event :approve_hot do
      transition [:pending, :published, :deferred] => :hot
    end
    
    event :approve_rejected do
      transition [:pending, :published, :hot, :deferred, :draft] => :rejected
    end
    
    event :defer do
      transition [:published, :hot] => :deferred
    end
    
    event :drafting do
      transition [:pending, :published, :hot, :rejected, :deferred] => :draft
    end
    
    event :edit do
      transition [:published, :hot, :rejected, :deferred, :draft] => :pending
    end
    
    event :approve_wait do
      transition :pending => :wait_company
    end
  end  
end

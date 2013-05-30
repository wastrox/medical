class Vacancy < ActiveRecord::Base
  attr_accessible :city, :description, :experiences, :name, :salary, :timetable, :timetable_other, :company_contact_id, :category_id, :hot_vacancy_attributes

  belongs_to :company
  belongs_to :company_contact
  belongs_to :category

  has_many :vacancy_responds
  has_many :applicants, :through => :vacancy_responds

  has_one :hot_vacancy, :dependent => :destroy
    accepts_nested_attributes_for :hot_vacancy, :allow_destroy => true

  validates_presence_of :category_id, :city, :description, :experiences, :name, :salary, :timetable, :company_contact_id

	define_index do
		indexes name 
    indexes created_at, sortable: true
		indexes city
		where " vacancies.state IN ('published', 'hot')" # Индексирует только опубликованные и горячие вакансии
		set_property :delta => :delayed
	end
	
	state_machine :state, :initial => :draft do
    # после реиндексации delta устанавливается в false для всего контента - так как он проиндексирован.
    # перед любым изменением состояния требуем переиндексировать контект по окончанию изменения состояния с помощью дельта-индексирования
    # http://stackoverflow.com/questions/4094982/rails-thinking-sphinx-how-do-i-set-delta-to-true-after-reindexing
    # Thinking Sphinx должен сам устанавливать delta=true после изменения данных в экземпляре класса, но используемая версия этого не делает.
    # Возможно, это баг используемой версии Thinking Sphinx. Фикс ниже - это временный work-around для этой проблемы.

    before_transition any => any do |content, transition|
      content.delta = true
    end

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

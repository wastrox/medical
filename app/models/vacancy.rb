class Vacancy < ActiveRecord::Base
  belongs_to :company
  belongs_to :company_contact
  attr_accessible :category, :city, :description, :experiences, :name, :salary, :timetable, :timetable_other, :company_contact_id

	define_index do
		indexes name 
		indexes city
		set_property :delta => :delayed
	end
	
	state_machine :state, :initial => :draft do
    event :request do
      transition :draft => :pending
    end
    
    event :approve_published do
      transition [:pending, :deffered] => :published
    end
    
    event :approve_hot do
      transition [:pending, :published, :deffered] => :hot
    end
    
    event :approve_rejected do
      transition :pending => :rejected
    end
    
    event :defer do
      transition [:published, :hot] => :deferred
    end
    
    event :drafting do
      transition [:pending, :published, :hot, :rejected, :deferred] => :draft
    end
    
    event :edit do
      transition [:published, :hot, :rejected, :deferred] => :pending
    end
  end
end

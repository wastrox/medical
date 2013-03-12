#encoding: utf-8
class Resume < ActiveRecord::Base
  attr_accessible :applicant, :position, :salary, :city, :additional_info, :profile_attributes, :experiences_attributes, :educations_attributes, :personal_data
  
  validate :applicant, :uniqueness => true
  #validates_presence_of :position, :salary, :city
  validates_acceptance_of :personal_data, :on => :create #, :allow_nil => :false
	
  belongs_to :applicant
	has_one :profile 
    accepts_nested_attributes_for :profile

	has_many :experiences, :dependent => :destroy
    accepts_nested_attributes_for :experiences, :allow_destroy => true
    
  has_many :educations, :dependent => :destroy
    accepts_nested_attributes_for :educations, :allow_destroy => true
    
  define_index do
  	indexes position 
  	indexes city
  	set_property :delta => :delayed
  	where " resumes.state IN ('published', 'hot')" # Индексирует только опубликованные и горячие резюме
  end
 
  	state_machine :state, :initial => :draft do
      event :request do
        transition :draft => :pending
      end

      event :approve_published do
        transition [:pending, :deferred, :hot, :secret, :rejected] => :published
      end

      event :approve_hot do
        transition [:pending, :published, :deferred, :secret, :rejected] => :hot
      end
      
      event :approve_secret do
        transition [:pending, :published, :hot, :deferred, :rejected] => :secret
      end

      event :approve_rejected do
        transition [:pending, :published, :hot, :secret, :deferred] => :rejected
      end

      event :defer do
        transition [:published, :hot, :secret] => :deferred
      end

      event :edit do
        transition [:published, :hot, :rejected, :deferred, :secret] => :pending
      end
    end
end

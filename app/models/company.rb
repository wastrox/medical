class Company < ActiveRecord::Base
  attr_accessible :logo, :description, :name, :scope, :site, :company_contacts_attributes

	has_attached_file :logo, :styles => { :small => "80x109>", :search => "40x38", :vip => "160x90>" }

  validates_presence_of :description, :name, :scope

  belongs_to :employer
  has_many :vacancies, :dependent => :destroy  
  has_many :company_contacts, :dependent => :destroy 
    accepts_nested_attributes_for :company_contacts, :allow_destroy => true
    
    state_machine :state, :initial => :draft do
      event :request do
        transition :draft => :pending
      end

      event :approve_published do
        transition [:pending, :vip, :rejected] => :published
      end

      event :approve_vip do
        transition [:pending, :published] => :vip
      end

      event :approve_rejected do
        transition [:pending, :published, :vip] => :rejected
      end

      event :edit do
        transition [:published, :vip, :rejected, :draft] => :pending
      end
    end
    
    define_index do
  		indexes name 
  		set_property :delta => :delayed
  		#where " companies.state IN ('published', 'vip')" # Индексирует только опубликованные и горячие компании
  	end
end

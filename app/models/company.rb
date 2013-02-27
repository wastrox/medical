class Company < ActiveRecord::Base
  attr_accessible :logo, :description, :name, :scope, :site, :company_contacts_attributes
	has_attached_file :logo, :styles => { :small => "150x150>" }

  belongs_to :employer
  has_many :vacancies, :dependent => :destroy
  
  has_many :company_contacts, :dependent => :destroy 
    accepts_nested_attributes_for :company_contacts, :allow_destroy => true
    
    state_machine :state, :initial => :draft do
      event :request do
        transition :draft => :pending
      end

      event :approve_published do
        transition [:pending, :vip] => :published
      end

      event :approve_vip do
        transition [:pending, :published] => :vip
      end

      event :approve_rejected do
        transition :pending => :rejected
      end

      event :edit do
        transition [:published, :vip, :rejected] => :pending
      end
    end
end

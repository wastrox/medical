class Company < ActiveRecord::Base
  attr_accessible :logo, :description, :name, :scope, :site, :company_contacts_attributes
	has_attached_file :logo, :styles => { :small => "150x150>" }

  belongs_to :employer
  has_many :vacancies
  
  has_many :company_contacts, :dependent => :destroy 
    accepts_nested_attributes_for :company_contacts, :allow_destroy => true
    
end

class Company < ActiveRecord::Base
  belongs_to :employer
  attr_accessible :description, :name, :scope, :site, :company_contacts_attributes
  
  has_many :company_contacts, :dependent => :destroy 
    accepts_nested_attributes_for :company_contacts, :allow_destroy => true
    
end

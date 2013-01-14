#encoding: utf-8
class Resume < ActiveRecord::Base
  attr_accessible :applicant, :position, :salary, :city, :additional_info, :profile_attributes, :experiences_attributes, :educations_attributes #:languages_attributes
  validate :applicant, :uniqueness => true

  #validates_presence_of :position, :salary, :city, :message => "Поле обязательно для заполнения", :on => :update
	
  #validates_associated :profile
  
  belongs_to :applicant
  
	has_one :profile 
    accepts_nested_attributes_for :profile

	has_many :experiences, :dependent => :destroy
    accepts_nested_attributes_for :experiences, :allow_destroy => true
    
  has_many :educations, :dependent => :destroy
    accepts_nested_attributes_for :educations, :allow_destroy => true
 
  #has_many :languages, :dependent => :destroy 
    #accepts_nested_attributes_for :languages, :allow_destroy => true ---> Это поле заменено на Resume.id.additonal_info
end

class Resume < ActiveRecord::Base
	attr_accessible :applicant, :resume, :experiences_attributes, :educations_attributes, :languages_attributes, :profile_attributes #:pc_skills_attributes
	
  validate :applicant, :uniqueness => true

  belongs_to :applicant

	has_one :profile 
    accepts_nested_attributes_for :profile 

	has_many :experiences, :dependent => :destroy
    accepts_nested_attributes_for :experiences, :allow_destroy => true
 
  has_many :educations, :dependent => :destroy
    accepts_nested_attributes_for :educations, :allow_destroy => true
 
  has_many :languages, :dependent => :destroy
    accepts_nested_attributes_for :languages, :allow_destroy => true
 
  has_many :pc_skills, :dependent => :destroy
    accepts_nested_attributes_for :pc_skills, :allow_destroy => true



end

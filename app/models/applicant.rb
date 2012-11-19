class Applicant < Account 
  attr_accessible :about_me, :city, :date, :firstname, :lastname, :phone, :surename, :experiences_attributes, :educations_attributes, :languages_attributes, :pc_skills_attributes
	attr_accessor :about_me, :city, :date, :firstname, :lastname, :phone, :surename, :experiences_attributes, :educations_attributes, :languages_attributes, :pc_skills_attributes

	has_many :experiences , :dependent => :destroy
		accepts_nested_attributes_for :experiences , :allow_destroy => true

	has_many :educations, :dependent => :destroy
		accepts_nested_attributes_for :educations, :allow_destroy => true

	has_many :languages, :dependent => :destroy
		accepts_nested_attributes_for :languages, :allow_destroy => true

	has_many :pc_skills, :dependent => :destroy
		accepts_nested_attributes_for :pc_skills, :allow_destroy => true
end

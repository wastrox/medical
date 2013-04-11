class Profile < ActiveRecord::Base
  attr_accessible :applicant_id, :resume, :lastname, :firstname, :surename, :date, :phone, :photo
	
	has_attached_file :photo, :styles => { :small => "126x150>", :show => "80x109>" }
  #validates_presence_of  :lastname, :firstname, :surename, :date, :phone
  
  belongs_to :resume
  belongs_to :applicant
end

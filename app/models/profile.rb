class Profile < ActiveRecord::Base
  attr_accessible :applicant_id, :resume, :lastname, :firstname, :surename, :date, :phone, :photo
	
	has_attached_file :photo, :styles => { :small => "150x150>", :show => "58x55>" }
  #validates_presence_of  :lastname, :firstname, :surename, :date, :phone
  
  belongs_to :resume
  belongs_to :applicant
     
end

class Profile < ActiveRecord::Base
  attr_accessible :applicant_id, :resume, :lastname, :firstname, :surename, :date, :phone

  belongs_to :resume
  belongs_to :applicant
  
  validates_presence_of  :lastname, :firstname, :surename, :phone
     
end

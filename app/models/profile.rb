class Profile < ActiveRecord::Base
  attr_accessible :applicant_id, :resume, :title, :lastname, :firstname, :surename, :date, :city, :phone, :about_me 

  belongs_to :resume
  belongs_to :applicant
end

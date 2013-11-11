class Profile < ActiveRecord::Base
  attr_accessible :applicant_id, :resume, :lastname, :firstname, :surename, :date, :phone, :photo

  has_attached_file :photo, :styles => { :small => "126x150>", :show => "80x109>", :search => "40x38" }, :default_url => "/assets/paperclip/missing_photo_:style.png"
  validates_presence_of  :lastname, :firstname, :surename, :date, :phone
  
  belongs_to :resume
  belongs_to :applicant
end

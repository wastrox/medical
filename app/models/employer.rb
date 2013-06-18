class Employer < Account 
	has_one :company

	has_many :resume_responds, :dependent => :destroy
  	has_many :resumes, :through => :resume_responds

  	def company?
  	    company
  	end
end

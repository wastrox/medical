class Applicant < Account 

  has_one :profile
	has_one :resume

	def resume?
		resume
	end

  def profile?
		profile
	end
end

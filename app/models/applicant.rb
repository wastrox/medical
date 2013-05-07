class Applicant < Account 

  has_one :profile
  has_one :resume
  has_many :vacancy_responds
  has_many :vacancies, :through => :vacancy_responds

	def resume?
		resume
	end

  def profile?
		profile
	end
end

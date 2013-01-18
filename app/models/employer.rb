class Employer < Account 
	has_one :company

  def company?
      company
  end
end

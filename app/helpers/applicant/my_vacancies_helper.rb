module Applicant::MyVacanciesHelper
	def category(vacancy)
		vacancy = Vacancy.find(vacancy.vacancy_id)
		category = vacancy.category
		return category
	end
end

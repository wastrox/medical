#encoding: utf-8
module SearchHelper
	def salary_searh_helper(object) # => хелпер для отображение зарплаты в заголовке вакансии, сопряжен с application хелпером salary_helper(object)
		salary_in = salary_helper(object)
		if salary_in.include? "грн"
			salary_out = "#{salary_in})"
		else
			salary_out = "зарплата не указана)"
		end
		return salary_out
	end

	def employer!
		user = current_user
		if user.employer? and user.company?
			company = user.company 
			if company.published? or company.vip?
				user = true
			else
				user = false
			end
		else 
			user = false
		end
		return user
	end
end

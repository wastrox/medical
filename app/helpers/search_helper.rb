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
				userEmployer = true
			else
				userEmployer = false
			end
		else 
			userEmployer = false
		end
		return userEmployer
	end

	def applicant!
		user = current_user
		if user.applicant? and user.resume?
			resume = user.resume
			case resume.state
			when "published", "hot", "deferred"
				userApplicant = true	
			else
				userApplicant = false
			end
		else
			userApplicant = false
		end
	end

	def userIsCustomer!
		if current_user and (employer! or applicant!)
			return true, "user is a customer company medical.netbee.ua"
		else
			return false
		end
	end

	def scope_title_helper
	  @scope == "drugoe" ? "Другие специальности" : @categories.first.scope.title
	end
end
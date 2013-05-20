# encoding: utf-8
class Notifier < ActionMailer::Base
  default from: "nicholauskas@gmail.com"

	def activation_instructions(account)
		@account_token = account.token
    	mail(:to => account.email, :subject => "Добро пожаловать на medical.netbee.ua")
	end
	
	def letter_from_moderator(account, text)
	  	@body_letter = text
	  	mail(:to => account.email, :subject => "Письмо от модератора")
	end

	def letter_to_company_from_moderator_published(account)
		@account = account
		mail(:to => account.email, :subject => "Профиль компании опубликован на сайте www.medical.netbee.ua")
	end

	def letter_to_company_from_moderator_reject(account, text)
		@account = account
	  	@body_letter = text
		mail(:to => account.email, :subject => "Профиль компании не опубликован на сайте www.medical.netbee.ua")
	end

	def letter_to_vacancy_from_moderator_published(account, vacancy)
		@account = account
		@vacancy = vacancy
		mail(:to => account.email, :subject => "Вакансия #{vacancy.name} опубликована на сайте")
	end

	def letter_to_vacancy_from_moderator_reject(account, vacancy, text)
		@account = account
		@vacancy = vacancy
	  	@body_letter = text
		mail(:to => account.email, :subject => "Профиль компании не опубликован на сайте www.medical.netbee.ua")
	end

	def letter_to_resume_from_moderator_published(account)
        @fullNameApplicant = "#{account.profile.lastname} #{account.profile.firstname} #{account.profile.surename}"
		@account = account
		mail(:to => account.email, :subject => "Резюме #{account.resume.position} опубликовано на сайте")
	end

	def letter_to_resume_from_moderator_reject(account, text)
		@body_letter = text
        @fullNameApplicant = "#{account.profile.lastname} #{account.profile.firstname} #{account.profile.surename}"
		@account = account
		mail(:to => account.email, :subject => "Резюме #{account.resume.position} не опубликовано на сайте")
	end

	def vacancy_respond(account, subject, applicant)

		@applicant = applicant
        @fullNameApplicant = "#{applicant.profile.lastname} #{applicant.profile.firstname} #{applicant.profile.surename}"
		@vacancy = subject

	  	mail(:to => account.email, :subject => "Отклик на вакансию #{subject.name}")
	end
end

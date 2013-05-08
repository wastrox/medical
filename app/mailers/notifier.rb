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

	def vacancy_respond(account, subject, applicant)

		@applicant = applicant
        @fullNameApplicant = "#{applicant.profile.lastname} #{applicant.profile.firstname} #{applicant.profile.surename}"
		@vacancy = subject

	  	mail(:to => account.email, :subject => "Отклик на вакансию #{subject.name}")
	end
end

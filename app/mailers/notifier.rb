# encoding: utf-8
class Notifier < ActionMailer::Base
  default from: "nicholauskas@gmail.com"

	def activation_instructions(account)
		@account_token = account.token
    	mail(:to => account.email, :subject => "Добро пожаловать на medical.netbee.ua")
	end

	def send_password_recovery(account)
		@account_token = account.token
    	mail(:to => account.email, :subject => "Восстановление пароля для medical.netbee.ua")
	end

	def send_activate_recovery(account)
		@account_token = account.token
    	mail(:to => account.email, :subject => "Восстановление активации для medical.netbee.ua")
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

	def letter_to_admin(subject, body_letter)
		@body_letter = body_letter
		mail(:to => ["personal@netbee.ua", "t@netbee.ua"], :subject => subject)
	end

	def letter_published_update_tomorrow(account, subject, vacancy, date)
	  	@account = account
	  	@vacancy = vacancy
	  	@date = date.tomorrow.strftime("%d.%m.%Y")
	  	mail(:to => account.email, :subject => "#{subject}")
	end

	def letter_published_update_today(account, subject, vacancy, date)
	  	@account = account
	  	@vacancy = vacancy
	  	@date = date.strftime("%d.%m.%Y")
	  	mail(:to => account.email, :subject => "#{subject}")
	end

	def letter_published_update(account, subject, vacancy, date)
	  	@account = account
	  	@vacancy = vacancy
	  	@date = date.next_month.strftime("%d.%m.%Y")
	  	mail(:to => account.email, :subject => "#{subject}")
	end

	def letter_nicholauskas_debug(objects, time, msg)
		@time = time
		@objects = objects
		@msg_error = msg
		mail(:to => "nicholauskas@gmail.com", :subject => "medical.netbee.ua логи выполнения.")
	end
end

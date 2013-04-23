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
end

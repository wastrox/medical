class Notifier < ActionMailer::Base
  default from: "nicholauskas@gmail.com"

	def activation_instructions(account)
		@account_activation_url = activate_account_url(account.token)
    mail(:to => account.email, :subject => "Welcome to My Awesome Site")
	end
	
	def letter_from_moderator(account, text)
	  @body_letter = text
	  mail(:to => account.email, :subject => "Letter from moderator")
	end

end

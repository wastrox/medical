class Notifier < ActionMailer::Base
  default from: "nicholauskas@gmail.com"

	def activation_instructions(account)
		@account_activation_url = activate_account_url(account.token)
    mail(:to => account.email, :subject => "Welcome to My Awesome Site")
	end

end

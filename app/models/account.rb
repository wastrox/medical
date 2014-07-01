# coding: utf-8
class Account < ActiveRecord::Base

  self.inheritance_column = 'account_type'

  attr_accessible :email, :password, :account_type

  validates :email, presence: true, :on => :create
  validates :password, presence: true, :on => :create
  
  validates :email, presence: true, :uniqueness => {:message => "Пользователь с таким email уже зарегистрирован."}
  
	has_secure_password
  before_save :encrypt_password, :access_token 
		
  def self.authenticate(email, password)
     account = find_by_email(email)
     if account && account.password_digest == BCrypt::Engine.hash_secret(password)
      user
    else
      nil
    end
  end

  def active?
    active
  end

  def activate!
    self.active = true
    save
  end

  def deactivate!
    self.active = false
    save
  end

	def send_activation_instructions!
		Notifier.activation_instructions(self).deliver		
	end

  def send_password_recovery!
    Notifier.send_password_recovery(self).deliver
  end

  def send_activate_recovery!
    Notifier.send_activate_recovery(self).deliver
  end

  def send_vacancy_respond(subject, applicant)
    Notifier.vacancy_respond(self, subject, applicant).deliver
  end

  def type?
		account_type
	end

	def create_type(person)
     self.account_type = person
		 save
  end
  
 def employer?  # => FIXME: метод используется в partial layouts/navbar. Заменить универсальным методом для Employer and Applicant
    type = self.account_type
    if type == "Employer"
      return true
    else
      return false
    end
 end
 
 def applicant?  # => FIXME: метод используется в partial layouts/navbar. Заменить универсальным методом для Employer and Applicant
     type = self.account_type
     if type == "Applicant"
       return true
     else
       return false
     end
  end
	
	def add_new_session_count 
		self.session_count += 1
		save
	end

	private

		def encrypt_password
    	if password.present?
      	self.salt = BCrypt::Engine.generate_salt
   		end
 		end

		def access_token
      self.token = rand(36**9).to_s(36) if self.new_record? and self.token.nil?
    end
end

# coding: utf-8
class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  self.inheritance_column = 'account_type'

  attr_accessible :email, :password, :account_type

  validates_confirmation_of :password, :if => :password_required?
  # validates :email, presence: true, :on => :create
  # validates :password, presence: true, :on => :create

  # validates :email, presence: true, :uniqueness => {:message => "Пользователь с таким email уже зарегистрирован."}

	# has_secure_password
  # before_save :encrypt_password, :access_token

  # def self.authenticate(email, password)
  #    account = find_by_email(email)
  #    if account && account.password_digest == BCrypt::Engine.hash_secret(password)
  #     user
  #   else
  #     nil
  #   end
  # end

    #  def self.authenticate(email, password)
    #     user = Account.find_for_authentication(:email => email)
    #     user.valid_password?(password) ? user : nil
    # end

  # def self.send_reset_password_instructions(attributes={})
  #   recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
  #   if !recoverable.approved?
  #     recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
  #   elsif recoverable.persisted?
  #     recoverable.send_reset_password_instructions
  #   end
  #   recoverable
  # end

  def unconfirmed?
    !self.confirmed?
  end

  # def active?
  #   active
  # end

  # def activate!
  #   self.active = true
  #   save
  # end

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

  def type_not_specified?
    self.account_type.nil? ? true : false 
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

  # new function to set the password without knowing the current password used in our confirmation controller. 
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end
  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # new function to provide access to protected method unless_confirmed
  def only_if_unconfirmed
    unless_confirmed {yield}
  end

  protected

  # def confirmation_required?
    # false
  # end

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
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

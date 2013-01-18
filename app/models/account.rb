class Account < ActiveRecord::Base
	set_inheritance_column :account_type
	attr_accessible :email, :password, :account_type => :false

  validates_presence_of [:password, :email], :on => :create
  validates :email, :uniqueness => true
  
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

  def type?
		account_type
	end

	def create_type(person)
     self.account_type = person
		 save
  end
  
 def employer?
    type = self.account_type
    if type == "Employer"
      return true
    else
      return false
    end
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

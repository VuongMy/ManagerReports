class User < ActiveRecord::Base
	belongs_to :group
	before_save { self.email = email.downcase }
  before_create :create_remember_token
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@framgia.com+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}

  #has_secure_password
	#validates :password, presence: true
	def User.new_remember_token
  	SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
  	Digest::SHA1.hexdigest(token.to_s)
	end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    def send_activation
      generate_token(:activation_token)
      UserMailer.activation(self).deliver
    end

    def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
    end
end

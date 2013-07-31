class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@framgia.com+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}
end

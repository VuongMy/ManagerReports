class User < ActiveRecord::Base
	belongs_to :group
	validates :group_id, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@framgia.com+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}
end

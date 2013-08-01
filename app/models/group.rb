class Group < ActiveRecord::Base
	has_many :user
	validates :group_name, presence:true
end

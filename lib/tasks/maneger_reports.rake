namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_groups

	end
	
end

def make_users
	admin = User.create(email: "admin@framgia.com",
						password: "123456",
						password_confirmation: "123456" ,
						# group_id: nil ,
						admin: true )
	10.times do |n|
		email = "framgia-#{n+1}@framgia.com"
		password = "1234560"
		# group_id = 1
		User.create!(email: email,
					password: password,
					# group_id: group_id ,
					password_confirmation: password )
	end
	# 40.times do |n|
	# 	email = "framgia-#{n+1}@framgia.com"
	# 	password = "1234560"
	# 	group_id = nil
	# 	User.create!(email: email,
	# 				password: password,
	# 				password_confirmation: password ,
	# 				group_id: group_id )
	# end
	
end

def make_groups
	5.times do |n|
		group_name = "group #{n+1}"
		manager_id = n+1
		Group.create!(group_name: group_name ,
					manager_id: manager_id )
	end
end
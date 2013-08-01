namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users

	end
	
end

def make_users
	admin = User.create(email: "admin@framgia.com",
						password: "123456",
						admin: true )
	10.times do |n|
		email = "framgia-#{n+1}@framgia.com"
		password = "1234560"
		User.create!(email: email,
					password: password)
	end
end
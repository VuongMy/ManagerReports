namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		

	end
	
end

def make_users
	admin = User.create(email: "admin@framgia.com",
						password: "123456",
						password_confirmation: "123456" ,
						admin: true , active: true )
	
end

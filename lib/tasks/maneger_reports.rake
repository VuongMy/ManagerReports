namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_groups
		make_catalogs

	end
	
end

def make_users
	admin = User.create(email: "admin@framgia.com",
						password: "123456",
						password_confirmation: "123456" ,
						admin: true , active: true )
	50.times do |n|
		email = "framgia-#{n+1}@framgia.com"
		password = "1234560"
		User.create!(email: email,
					password: password,
					password_confirmation: password )
	end	
end

def make_groups
	5.times do |n|
		group_name = "group #{n+1}"
		manager_id = n+1
		Group.create!(group_name: group_name ,
					manager_id: manager_id )
	end
end

def make_catalogs
	5.times do |n|
		title = "title #{n+1}: dien cac thong tin hang ngay"
		detail = "detail #{n+1}: huong dan dien thong tin cho cac title"
		Catalog.create!(title: title,
						detail: detail )
	end
end
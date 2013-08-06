module ApplicationHelper
	require 'rubygems'
  	require 'rufus/scheduler'

	def auto_send_report 
		scheduler = Rufus::Scheduler.start_new
		groups = Group.all
		scheduler.cron '0 17 * * 1-5' do
			groups.each do |group|
				manager = User.find_by_id(group.manager_id)
				users=group.user
				users.each do |user|
					if user.id != manager.id
		    			UserMailer.send_report(manager,user).deliver
		    		end
		    	end
		    end
	  	end
	end
end

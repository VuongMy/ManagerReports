require 'securerandom'

class UserMailer < ActionMailer::Base  
  default :from => "framgia.jp@gmail.com"  
  
  def registration_confirmation(user)
    @user=user
    mail(:to => user.email,:subject => "Registered")
  end

  def activation(user)
  	@user = user
  	mail(:to => "vuongmy91@gmail.com", :subject => "Have a account needs to be actived")
  end 

  def send_report(manager,user)
    @user = user
    @manager = manager
    time = Time.new
    mail(:to => @manager.email, :subject =>"[#{@user.email}][Daily report]#{time.year}-#{time.month}-#{time.day}")
  end
end  
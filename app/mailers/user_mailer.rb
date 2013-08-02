  	require 'securerandom'

  	class UserMailer < ActionMailer::Base  
      default :from => "ngoduytrung2901@gmail.com"  
      
      def registration_confirmation(user)
        
        mail(:to => user.email,:subject => "Registered",
        	:body => ("email: #{user.email}\n pass: #{user.password} \n#{user.password_digest}"))
      end

      def activation(user)
      	@user = user
      	mail(:to => user.email, :subject => "test")#, :body => "#{Digest::MD5::hexdigest(@user.email)}")
      end 

      def send_user

      	mail(:to => "ngoduytrung2901@gmail.com", :subject => "test1")
      end  
    end  
  	require 'securerandom'

  	class UserMailer < ActionMailer::Base  
      default :from => "vuongmy91@gmail.com"  
      
      def registration_confirmation(user)
        mail(:to => user.email,:subject => "Registered",
        	:body => ("email: #{user.email}\n pass: #{SecureRandom.urlsafe_base64(9)}")) 
        	
      end

      def send_to_admin(user)
      	@user = user
      	mail(:to => "vuongmy91@gmail.com", :subject => "test")#, :body => "#{Digest::MD5::hexdigest(@user.email)}")
      end 

      def send_user

      	mail(:to => "traidatquaytron91@gmail.com", :subject => "test1")
      end  
    end  
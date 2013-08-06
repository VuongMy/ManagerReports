  	require 'securerandom'

  	class UserMailer < ActionMailer::Base  
      default :from => "vuongmy91@gmail.com"  
      
      def registration_confirmation(user)
        @user = user
        password = SecureRandom.urlsafe_base64(9)
        user.password_digest = Digest::SHA1::hexdigest(password)
        mail(:to => user.email,:subject => "Registered",
        	:body => ("email: #{user.email}\n pass: #{password} \n#{user.password_digest}"))
        user.save	
      end

      def activation(user)
      	@user = user
      	mail(:to => "vuongmy91@gmail.com", :subject => "test")#, :body => "#{Digest::MD5::hexdigest(@user.email)}")
      end 

      def send_report(manager,user)
        @user = user
        @manager = manager
        mail(:to => @manager.email, :subject =>"test")
      end

      def send_user

      	mail(:to => "traidatquaytron91@gmail.com", :subject => "test1")
      end  
    end  
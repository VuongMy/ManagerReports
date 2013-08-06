ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "ngoduytrung2901@gmail.com",  
  :user_name            => "ngoduytrung2901@gmail.com",  
  :password             => "trodjngung01",  
  :authentication       => "plain",  
  :enable_starttls_auto => true   
} 
ActionMailer::Base.default_url_options[:host] = "localhost:3000"  
ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "traidatquaytron91@gmail.com",  
  :user_name            => "traidatquaytron91@gmail.com",  
  :password             => "vuongthimy91",  
  :authentication       => "plain",  
  :enable_starttls_auto => true   
} 
ActionMailer::Base.default_url_options[:host] = "localhost:3000"  
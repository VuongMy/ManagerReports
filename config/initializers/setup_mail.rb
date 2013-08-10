ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "framgia.jp@gmail.com",  
  :user_name            => "framgia.jp@gmail.com",  
  :password             => "framgiavn",  
  :authentication       => "plain",  
  :enable_starttls_auto => true   
} 
ActionMailer::Base.default_url_options[:host] = "localhost:3000"  
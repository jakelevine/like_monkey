Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :tumblr, ENV['API_KEY'], ENV['API_SECRET']
  
  

end

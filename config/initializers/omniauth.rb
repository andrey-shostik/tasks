Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['vk_key'], ENV['vk_secret'], scope: 'email'
  provider :google_oauth2, ENV['google_key'], ENV['google_secret']
  provider :github, ENV['github_key'], ENV['github_secret'], scope: "user:email,user:follow"
end

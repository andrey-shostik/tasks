Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['facebook_key'], ENV['facebook_secret']
  provider :vkontakte, ENV['vk_key'], ENV['vk_secret'], scope: 'email'
  provider :gplus, ENV['gplus_key'], ENV['gplus_secret']
end

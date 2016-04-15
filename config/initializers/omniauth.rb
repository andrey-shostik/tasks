Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1287307147950050', '8ac4c26320740b9f201a358169cbd0f0'
  provider :vkontakte, ENV['vk_key'], ENV['vk_secret'], scope: 'email'
  # provider :vkontakte, '5414114', 'oox62tsNeLHpTJbAtkbS', scope: 'email'
end

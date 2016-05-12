FactoryGirl.define do
  factory :item do
    uid 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
    provider %w(github google_oauth2 vkontakte).sample
    email 'somemail@mail.com'
  end
end

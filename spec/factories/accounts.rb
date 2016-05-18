FactoryGirl.define do
  factory :account do
    uid '106235777974783542914'
    provider 'google_oauth2'
    email 'somemail@mail.com'
    user nil
  end
end

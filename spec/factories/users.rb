FactoryGirl.define do
  factory :user do
    email 'somemail@mail.com'
    password '111111'
    password_confirmation '111111'
    token 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
  end
end

FactoryGirl.define do
  factory :item do |f|
    f.title Faker::Name.title
    f.description Faker::Lorem.paragraph
  end
end

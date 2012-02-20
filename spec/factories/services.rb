FactoryGirl.define do
  factory :service do
    name { Faker::Name.name }
    desc { Faker::Lorem.sentence }
    user
  end
  
#  factory :service_with_user, parent: :service do
#    user
#  end
end
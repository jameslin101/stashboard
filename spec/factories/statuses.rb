FactoryGirl.define do
  factory :status do
    time { Time.now }
    state { Status::STATETYPES.sample }
    message { Faker::HipsterIpsum.sentence }
    service
  end

end
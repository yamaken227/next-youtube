FactoryBot.define do
  factory :user do
    channel_name          { Faker::Name.initials(number: 6) }
    email                 { Faker::Internet.free_email }
    password              { 'abc123abc' }
    password_confirmation { password }
    subscribers_num       { 1000 }
    channel_url           { 'httppppppppppp' }
    what_channel          { 'これはテストです。' }
  end
end

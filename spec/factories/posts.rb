FactoryBot.define do
  factory :post do
    title          { Faker::Name.initials }
    highlights     { 'あいうえお' }
    video_url      { 'httt:aaa' }
    association :user
  end
end

FactoryBot.define do
  factory :post do
    title          { Faker::Name.initials }
    highlights     { 'あいうえお' }
    video_url      { 'https://www.youtube.com/watch?v=cCmT1fi7Jla' }
    association :user
  end
end

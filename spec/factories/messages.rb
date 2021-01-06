FactoryBot.define do
  factory :message do
    message          { 'すてきですね' }
    association :post
  end
end




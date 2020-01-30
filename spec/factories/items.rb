FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::TvShows::NewGirl.quote }
    unit_price { 1 }
    merchant { nil }
  end
end

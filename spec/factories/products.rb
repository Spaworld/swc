FactoryGirl.define do
  factory :product do
    name              { FFaker::Lorem.word }
    legacy_id         { rand(0...100) }
    price_in_dollars  { rand(0.00...100.00).round(2) }
  end
end

FactoryGirl.define do
  factory :product do
    name              { FFaker::Lorem.word }
    legacy_id         { rand(0...100) }
  end
end

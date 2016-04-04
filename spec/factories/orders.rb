FactoryGirl.define do
  factory :order do
    channel_id        { ENV['SELECTED_CHANNELS'].split(',').sample.to_i }
    price_in_dollars  { rand(0.0...10.0).round(2) }
    placement_date    { FFaker::Time.date }
    legacy_id         { rand(0...100) }
  end
end

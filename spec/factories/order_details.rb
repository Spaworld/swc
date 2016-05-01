FactoryGirl.define do
  factory :order_detail do
    order_id    { rand(0...999_999) }
    product_id  { rand(0...999_999) }
    quantity    { rand(1...999_999) }
  end
end

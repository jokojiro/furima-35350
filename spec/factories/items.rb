FactoryBot.define do
  factory :item do
    title                 { 'test-title' }
    description           { 'test-description' }
    category_id           { 2 }
    condition_id        { 2 }
    shipping_id       { 2 }
    area_id     { 2 }
    delivery_days_id   { 2 }
    price                 { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
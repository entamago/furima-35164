FactoryBot.define do
  factory :item do
    name                    {Faker::Lorem.word}
    price                   {Faker::Number.between(from: 300, to: 9999999)}
    info                    {Faker::Lorem.sentence}
    category_id             {Faker::Number.between(from: 1, to: 10)}
    sales_status_id         {Faker::Number.between(from: 1, to: 6)}
    fee_status_id           {Faker::Number.between(from: 1, to: 2)}
    prefecture_id           {Faker::Number.between(from: 1, to: 47)}
    scheduled_delivery_id   {Faker::Number.between(from: 1, to: 3)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

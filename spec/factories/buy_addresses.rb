FactoryBot.define do
  factory :buy_address do
    postal_code       { '123-4567' }
    prefecture_id     { Faker::Number.between(from: 1, to: 47) }
    city              { Faker::Address.city }
    address           { Faker::Address.street_address }
    building          { 'イグザンプルビル' }
    phone_number      { Faker::Number.leading_zero_number(digits: 11) }
    token             { "tok_abcdefghijk00000000000000000" }
  end
end

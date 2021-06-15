FactoryBot.define do
  factory :user do
    transient do
      real_name { Gimei.name }
    end
    nickname              { Faker::Name.last_name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { real_name.last.kanji }
    first_name            { real_name.first.kanji }
    last_name_kana        { real_name.last.katakana }
    first_name_kana       { real_name.first.katakana }
    birth_date            { Faker::Date.between(from: '1930-01-01', to: 5.year.ago) }
  end
end

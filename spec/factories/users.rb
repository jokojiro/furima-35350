FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(last_name)}
    email                 {Faker::Internet.free_email}
    password              {'1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    first_name            { '漢カな' }
    last_name             { '字キに' }
    first_name_kana       { 'カンカナ' }
    last_name_kana        { 'ジキニ' }
    birthday              {{1=>2000, 2=>1, 3=>24}}
  end
end
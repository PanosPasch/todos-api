FactoryBot.define do
    factory :todo do
        title { Faker::Lorem.word }
        created_by { Faker::Number.decimal_part(digits: 10).to_s }
    end
end
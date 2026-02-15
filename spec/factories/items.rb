FactoryBot.define do
    factory :item do
        name { Faker::Commerce.product_name }
        done { false }
        todo_id { nil }
    end
end
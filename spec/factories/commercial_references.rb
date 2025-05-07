FactoryBot.define do
  factory :commercial_reference do
    person { nil }
    company_name { "MyString" }
    phone { "MyString" }
    attendant { "MyString" }
    first_purchase { "2025-05-05" }
    largest_purchase { "9.99" }
    last_purchase { "2025-05-05" }
    payment_method { "MyString" }
    observation { "MyString" }
  end
end

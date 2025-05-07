FactoryBot.define do
  factory :bank_reference do
    person { nil }
    bank_name { "MyString" }
    agency { "MyString" }
    account { "MyString" }
    phone { "MyString" }
  end
end

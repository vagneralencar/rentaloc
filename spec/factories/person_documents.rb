FactoryBot.define do
  factory :person_document do
    person { nil }
    tenant { nil }
    description { "MyText" }
  end
end

FactoryBot.define do
  factory :related_person do
    person { nil }
    cpf_cnpj { "MyString" }
    name { "MyString" }
    relation_type { "MyString" }
    active { false }
  end
end

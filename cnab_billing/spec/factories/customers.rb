FactoryBot.define do
  factory :customer do
    cpf { CPF.generate }

    trait :invalid do
      cpf { '123456' }
    end
  end
end

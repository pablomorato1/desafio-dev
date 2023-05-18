FactoryBot.define do
  factory :transaction do
    transaction_type { 'credit' }
    date_register { Time.now.strftime("%d-%m-%Y") }
    value { 129.5 }
    card_number { '1234****4321' }
    hour_transaction { Time.now.strftime("%H:%M:%S") }
  end
end

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    context 'when all required attributes are provided' do
      let(:customer) { create(:customer) }
      let(:provider) { create(:provider) }
      let(:transaction_params) do
        {
          transaction_type: :credit,
          date_register: Time.now.strftime('%d-%m-%Y'),
          value: 129.5,
          card_number: '1234****4321',
          hour_transaction: Time.now.strftime('%H:%M:%S'),
          customer: customer,
          provider: provider
        }
      end

      it 'is valid' do
        transaction = described_class.create(transaction_params)
        expect(transaction).to be_valid
      end

      it 'sets all attributes correctly' do
        transaction = described_class.create(transaction_params)
        expect(transaction.transaction_type).to eq('credit')
        expect(transaction.date_register).to eq(transaction_params[:date_register])
        expect(transaction.value).to eq(129.5)
        expect(transaction.card_number).to eq('1234****4321')
        expect(transaction.hour_transaction).to eq(transaction_params[:hour_transaction])
        expect(transaction.customer).to eq(customer)
        expect(transaction.provider).to eq(provider)
      end
    end

    context 'when customer is not specified' do
      let(:transaction) { build(:transaction, customer: nil) }

      it 'is invalid' do
        expect(transaction).to be_invalid
      end

      it 'has an error message' do
        transaction.valid?
        expect(transaction.errors[:customer]).to include('must exist')
      end
    end

    context 'when provider is not specified' do
      let(:transaction) { build(:transaction, provider: nil) }

      it 'is invalid' do
        expect(transaction).to be_invalid
      end

      it 'has an error message' do
        transaction.valid?
        expect(transaction.errors[:provider]).to include('must exist')
      end
    end
  end

  describe 'callbacks' do
    let(:customer) { create(:customer) }
    let(:provider) { create(:provider) }
    context 'before_save' do
      let(:transaction) { create(:transaction, customer: customer, provider: provider) }

      it "verifies if set_if_transaction_is_income was correctly called by checking what it do" do
        expect(transaction.is_income).to be(true)
      end
    end
  end

  describe 'methods' do
    let(:customer) { create(:customer) }
    let(:provider) { create(:provider) }
    describe '#nature' do
      context 'when is_income is true' do
        let(:transaction) { create(:transaction, customer: customer, provider: provider, is_income: true) }

        it "returns 'Entrada'" do
          expect(transaction.nature).to eq('Entrada')
        end
      end

      context 'when is_income is false' do
        let(:transaction) { create(:transaction, customer: customer, provider: provider, transaction_type: 'ticket') }

        it "returns 'Saída'" do
          expect(transaction.nature).to eq('Saída')
        end
      end
    end
  end
end

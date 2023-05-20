require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe 'validations' do
    context 'when all attributes are valid' do
      let(:provider) { build(:provider) }

      it 'is valid' do
        expect(provider).to be_valid
      end
    end

    context 'when name_provider has already been taken' do
      let!(:existing_provider) { create(:provider) }
      let(:provider) { build(:provider, name_provider: existing_provider.name_provider) }

      it 'is invalid' do
        expect(provider).to be_invalid
      end

      it 'has an error message' do
        provider.valid?
        expect(provider.errors[:name_provider]).to include('has already been taken')
      end
    end
  end

  describe 'callbacks' do
    context 'before_validation' do
      let(:provider) { build(:provider, name_provider: 'Provider Name') }

      it 'calls parse_name' do
        expect(provider).to receive(:parse_name)
        provider.valid?
      end

      it 'downcases the name_provider attribute' do
        provider.valid?
        expect(provider.name_provider).to eq('provider name')
      end
    end
  end

  describe ".with_transaction_values" do
    let!(:provider) { create(:provider) }
    let!(:customer) { create(:customer) }
    let!(:transaction1) { create(:transaction, provider: provider, customer: customer, value: 100, transaction_type: 'sale') }
    let!(:transaction2) { create(:transaction, provider: provider, customer: customer,value: 50, transaction_type: 'ticket') }
    let!(:transaction3) { create(:transaction, provider: provider, customer: customer,value: 200, transaction_type: 'credit') }

    it "returns the correct total transaction value" do
      providers = Provider.with_transaction_values
      expect(providers.length).to eq(1)

      provider_with_value = providers.first
      expect(provider_with_value).to eq(provider)
      expect(provider_with_value.total_transaction_value).to eq(250) # 100 + (-50) + 200
    end
  end
end

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
end

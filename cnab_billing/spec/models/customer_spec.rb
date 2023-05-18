require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    let!(:existing_customer) { create(:customer) }

    context 'when CPF is valid' do
      let(:customer) { build(:customer) }

      it 'is valid' do
        expect(customer).to be_valid
      end
    end

    context 'when CPF is invalid' do
      let(:customer) { build(:customer, cpf: '12345678900') }

      it 'is invalid' do
        expect(customer).to be_invalid
      end

      it 'has an error message' do
        customer.valid?
        expect(customer.errors[:cpf]).to include('CPF invalido')
      end
    end

    context 'when creating a new object with a registered CPF' do
      let(:customer) { build(:customer, cpf: existing_customer.cpf) }

      it 'is invalid' do
        expect(customer).to be_invalid
      end

      it 'has an error message' do
        customer.valid?
        expect(customer.errors[:cpf]).to include('has already been taken')
      end
    end

    context 'when updating an object with a registered CPF' do
      let(:customer) { build(:customer, cpf: existing_customer.cpf) }

      it 'is invalid' do
        expect(customer).to be_invalid
      end

      it 'has an error message' do
        customer.valid?
        expect(customer.errors[:cpf]).to include('has already been taken')
      end
    end
  end
end

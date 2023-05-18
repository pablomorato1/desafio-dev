# frozen_string_literal: true

class Customer < ApplicationRecord
  validate :cpf_is_valid, on: %i[create update]
  validates :cpf, presence: true, uniqueness: true

  def cpf_is_valid?
    return errors.add(:cpf, 'CPF invalido') unless CPF.valid?(cpf)
  end
end

# frozen_string_literal: true

class Customer < ApplicationRecord
  before_save :parse_cpf

  validate :cpf_is_valid, on: %i[create update]
  validates :cpf, presence: true, uniqueness: true

  def cpf_is_valid
    return errors.add(:cpf, 'CPF invalido') unless CPF.valid?(cpf)
  end

  private

  def parse_cpf
    self.cpf = CPF.new(cpf).stripped
  end
end

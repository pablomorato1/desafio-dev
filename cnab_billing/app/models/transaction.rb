# frozen_string_literal: true

class Transaction < ApplicationRecord
  before_save :set_if_transaction_is_income

  TRANSACTION_TYPES_OUTCOME = %w[ticket financing rent].freeze

  validates :transaction_type, presence: true
  belongs_to :customer
  belongs_to :provider

  enum transaction_type: %i[debit ticket financing credit loan sale ted doc rent]

  def nature
    is_income ? 'Entrada' : 'Saída'
  end

  private

  def set_if_transaction_is_income
    self.is_income = !TRANSACTION_TYPES_OUTCOME.include?(transaction_type)
  end
end

# frozen_string_literal: true

class Transaction < ApplicationRecord
  before_save :set_if_transaction_is_income

  TRANSACTION_TYPES_OUTCOME = %w[ticket financing rent]

  validates :transaction_type, presence: true
  belongs_to :customer
  belongs_to :provider

  enum transaction_type: %i[debit ticket financing credit loan sale ted doc rent]

  private

  def set_if_transaction_is_income
    is_income = !TRANSACTION_TYPES_OUTCOME.include?(self.transaction_type)
  end
end

# frozen_string_literal: true

class Provider < ApplicationRecord
  before_validation :parse_name

  validates :name_provider, presence: true, uniqueness: true

  has_many :transactions

  scope :with_transaction_values, -> {
    select('providers.*, SUM(CASE WHEN transactions.is_income THEN transactions.value ELSE -transactions.value END) AS total_transaction_value')
      .joins(:transactions)
      .group('providers.id')
  }

  private

  def parse_name
    name_provider.downcase!
  end
end

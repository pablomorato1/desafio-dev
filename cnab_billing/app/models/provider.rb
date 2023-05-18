# frozen_string_literal: true

class Provider < ApplicationRecord
  before_validation :parse_name

  validates :name_provider, presence: true, uniqueness: true

  private

  def parse_name
    name_provider.downcase!
  end
end

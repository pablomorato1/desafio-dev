# frozen_string_literal: true

class Provider < ApplicationRecord
  before_validation :parse_names

  validates :name_provider, presence: true, uniqueness: true

  private

  def parse_names
    if self.valid?
      name_provider.downcase!
      name_owner.downcase!
    end
  end
end

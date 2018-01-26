# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :subjects, dependent: :destroy

  validates :name,
    presence: true,
    length: { minimum: 2 },
    uniqueness: true
end

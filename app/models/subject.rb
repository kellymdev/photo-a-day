# frozen_string_literal: true

class Subject < ApplicationRecord
  belongs_to :category
  has_many :photos, dependent: :destroy

  validates :name,
    presence: true,
    length: { minimum: 2 },
    uniqueness: true
end

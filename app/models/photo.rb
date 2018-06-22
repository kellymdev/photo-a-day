# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :subject

  validates :date, presence: true

  scope :most_recent_first, -> { order(date: :desc) }
end

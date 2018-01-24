# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :subject

  validates :date, presence: true
end

class Category < ApplicationRecord
  has_many :subjects

  validates :name,
    presence: true,
    length: { minimum: 2 }
end

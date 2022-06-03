class Form < ApplicationRecord
  validates :field, presence: true
  validates :region, presence: true
  validates :objective, presence: true
end

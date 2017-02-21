class TimeManager < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :from, presence: true
  validates :to, presence: true

  enum status: [:next, :doing, :done]
end

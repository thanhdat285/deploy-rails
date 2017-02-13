class Financial < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :money, presence: true
  validates :user_id, presence: true
  validates :day, presence: true
end

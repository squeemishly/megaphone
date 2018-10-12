class Customer < ApplicationRecord
  has_many :services

  validates :customer_id, :name, presence: true
end

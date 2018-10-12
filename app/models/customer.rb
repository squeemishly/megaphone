class Customer < ApplicationRecord
  has_many :configurations

  validates :customer_id, :name, presence: true
end

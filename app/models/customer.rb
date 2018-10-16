class Customer < ApplicationRecord
  has_many :services, dependent: :destroy

  validates :customer_id, :name, presence: true
end

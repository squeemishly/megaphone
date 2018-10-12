class Service < ApplicationRecord
  belongs_to :customer

  validates :service_id, :service_name, :active_version, :customer_id, presence: true
end

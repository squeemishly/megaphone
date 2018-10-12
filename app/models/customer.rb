class Customer < ApplicationRecord
  has_many :configurations

  validates :customer_id, :name, presence: true

  def self.find_customer(customer_id, service_name)
    customer = Customer.find_by(customer_id: customer_id)

    if !customer
      customer = Customer.create(
        customer_id: customer_id,
        name: service_name
      )
    end
  end
end

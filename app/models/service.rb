class Service < ApplicationRecord
  belongs_to :customer

  validates :service_id, :service_name, :active_version, :customer_id, presence: true

  scope :most_recent, -> { all.order(:updated_at).reverse }

  def self.process_service(service)
    if service[:active]
      create_or_update_service(service)
    end
  end

  private

  def self.create_or_update_service(raw_service)
    saved_service = Service.find_by(service_id: raw_service[:id])

    if saved_service
      update_service(saved_service, raw_service)
    else
      create_service(raw_service)
    end
  end

  def self.update_service(saved_service, service)
    if saved_service.active_version != service[:number]
      saved_service.update(
        service_name: service[:name],
        active_version: service[:number],
        previous_version: saved_service[:active_version]
      )
    end
  end

  def self.create_service(service)
    customer = Customer.find_or_create_by(customer_id: service[:cust_id]) do |customer|
      customer.name = service[:name]
    end

    Service.create(
      service_id: service[:id],
      service_name: service[:name],
      active_version: service[:number],
      customer_id: customer.id
    )
  end
end

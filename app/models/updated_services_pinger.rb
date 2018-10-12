class UpdatedServicesPinger
  def initialize
    @conn = Faraday.new('https://app.fastly.com/admin/changes?interval=10')
  end

  def self.ping
    new.ping
  end

  def ping
    resp = @conn.get do |req|
      req.headers["Fastly-key"] = ENV["fastly_api_key"]
    end

    pretty_resp = JSON.parse(resp.body, symbolize_names: true)

    pretty_resp.each do |service|
      if service[:active] != nil
        config = Service.find_by(service_id: service[:id])

        if config
          if config.active_version != service[:number]
            config.update(active_version: service[:number], previous_version: config[:active_version])
          end
        else
          customer = Customer.find_by(customer_id: service[:cust_id])

          if customer
            Service.create(service_id: service[:id], service_name: service[:name], active_version: service[:number], customer_id: customer.id)
          else
            customer = Customer.create(customer_id: service[:cust_id], name: service[:customer])

            Service.create(service_id: service[:id], service_name: service[:name], active_version: service[:number], customer_id: customer.id)
          end
        end
      end
    end
  end
end

class UpdatedServicesProcessor
  def self.process(response)
    pretty_resp = JSON.parse(response.body, symbolize_names: true)

    pretty_resp.each do |service|
      Service.process_service(service)
    end
  end
end

class UpdateServices
  def self.update
    ping = UpdatedServicesPinger.ping
    pretty_resp = JSON.parse(ping.body, symbolize_names: true)

    pretty_resp.each do |service|
      Service.process_service(service)
    end
  end
end

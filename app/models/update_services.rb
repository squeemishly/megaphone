class UpdateServices
  def self.update_services
    ping = UpdatedServicesPinger.ping
    UpdatedServicesProcessor.process(ping)
  end
end

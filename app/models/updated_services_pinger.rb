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
      Service.process_service(service)
    end
  end
end

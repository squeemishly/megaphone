require 'rails_helper'

describe UpdatedServicesProcessor do
  context ".process" do
    it "processes each service" do
      stubs = Faraday::Adapter::Test::Stubs.new

      response = Faraday.new do |builder|
        builder.adapter :test, stubs do |stub|
          stub.get('/pings') { |env| [ 200, {}, "[{\"id\":\"4v6h6swWZaT0GMz948Q2x8\"}]" ]}
        end
      end

      resp = response.get 'pings'
      pretty_resp = JSON.parse(resp.body, symbolize_names: true)

      allow(Service).to receive(:process_service)
        .with(pretty_resp.first)
        .and_return([{id:"4v6h6swWZaT0GMz948Q2x8"}])

      result = UpdatedServicesProcessor.process(resp)

      expect(result).to be_a Array
      expect(result.first).to be_a Hash
      expect(result).to eq [{:id=>"4v6h6swWZaT0GMz948Q2x8"}]
    end
  end
end

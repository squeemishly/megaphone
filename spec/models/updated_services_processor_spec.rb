require 'rails_helper'

describe UpdatedServicesProcessor do
  context ".process" do
    it "processes each service" do
      stubs = Faraday::Adapter::Test::Stubs.new

      response = Faraday.new do |builder|
        builder.adapter :test, stubs do |stub|
          stub.get('/pings') { |env| [ 200, {}, "[{\"id\":\"fake id\"}]" ]}
        end
      end

      resp = response.get 'pings'
      pretty_resp = JSON.parse(resp.body, symbolize_names: true)

      allow(Service).to receive(:process_service)
        .with(pretty_resp.first)
        .and_return([{id:"fake id"}])

      result = UpdatedServicesProcessor.process(resp)

      expect(result).to be_a Array
      expect(result.first).to be_a Hash
      expect(result).to eq [{:id=>"fake id"}]
    end
  end
end

require 'rails_helper'

describe UpdateServices do
  context ".update_services" do
    it "calls the appropriate methods to ping and process a ping" do
      stubs = Faraday::Adapter::Test::Stubs.new

      response = Faraday.new do |builder|
        builder.adapter :test, stubs do |stub|
          stub.get('/pings') { |env| [ 200, {}, "[{\"id\":\"fake id\"}]" ]}
        end
      end

      resp = response.get 'pings'

      allow(UpdatedServicesPinger).to receive(:ping)
        .once
        .and_return(resp)

      pretty_resp = JSON.parse(resp.body, symbolize_names: true)

      allow(Service).to receive(:process_service)
        .with(pretty_resp.first)
        .and_return([{id:"fake id"}])

      final = UpdateServices.update

      expect(final).to eq [{id:"fake id"}]
    end
  end
end

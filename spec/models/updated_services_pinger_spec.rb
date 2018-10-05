require 'rails_helper'

describe "UpdatedServicesPinger.ping" do
  it 'returns a hash of service objects' do
    stub_request(:get, "https://app.fastly.com/admin/changes?interval=10").
       with(
         headers: {
          'Fastly-Key'=> ENV["fastly_api_key"]
         }).
       to_return(status: 200, body: "[{\"id\":\"fake_id\",\"customer\":\"fake_customer_name\",\"name\":\"fake_service_name\",\"generation\":1,\"updated\":\"2018-10-04T15:21:14Z\",\"active\":null,\"number\":284,\"cust_id\":\"fake_customer_id\"}]", headers: {})

    ping = UpdatedServicesPinger.ping

    expect(ping).to be_an Array
    expect(ping.first).to be_an Hash
    expect(ping.first).to have_key :id
    expect(ping.first[:id]).to eq "fake_id"
    expect(ping.first).to have_key :customer
    expect(ping.first[:customer]).to eq "fake_customer_name"
    expect(ping.first).to have_key :name
    expect(ping.first[:name]).to eq "fake_service_name"
    expect(ping.first).to have_key :active
    expect(ping.first[:active]).to eq nil
    expect(ping.first).to have_key :number
    expect(ping.first[:number]).to eq 284
    expect(ping.first).to have_key :cust_id
    expect(ping.first[:cust_id]).to eq "fake_customer_id"
  end
end

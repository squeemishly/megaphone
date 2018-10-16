require 'rails_helper'

describe UpdateServices do
  context ".update_services" do
    it "calls the appropriate methods to ping and process a ping" do
      allow(UpdatedServicesPinger).to receive(:ping)
        .and_return(:fake_object)
      allow(UpdatedServicesProcessor).to receive(:process)
        .with(:fake_object)
        .and_return(:fake_result)

      final = UpdateServices.update_services

      expect(final).to eq :fake_result
    end
  end
end

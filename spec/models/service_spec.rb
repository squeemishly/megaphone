require 'rails_helper'

describe Service, type: :model do
  describe "attributes" do
    it { should validate_presence_of(:service_id) }
    it { should validate_presence_of(:service_name) }
    it { should validate_presence_of(:active_version) }
    it { should validate_presence_of(:customer_id) }
  end

  describe "relationships" do
    it { should belong_to(:customer) }
  end

  describe "methods" do
    describe ".process_service" do
      context "the configuration is not active" do
        it "does not process the service and returns the raw service"
      end

      context "the configuration is active" do
        context "a service already exists" do
          it "updates the service"
        end

        context "it is a new service" do
          it "creates a new service"
        end
      end
    end
  end
end

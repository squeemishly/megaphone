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
        it "does not process the service and returns the raw service" do
          service = {:active=>nil}

          expect(Service.process_service(service)).to eq nil
        end
      end

      context "the configuration is active" do
        before(:each) do
          @service = {id: "4iF5WsVstlE4TauZYacuyO",
                       customer: "Jonathan Foote",
                       name: "testing",
                       active: 1,
                       number: 2,
                       cust_id: "6ARY9ZJiyoSmIXMwG16qw0"}
        end

        context "a service already exists" do
          context "the active version is different that new version" do
            it "updates the service" do
              customer = Customer.create(customer_id: "6ARY9ZJiyoSmIXMwG16qw0",
                                          name: "Jonathan Foote")

              Service.create(service_id: "4iF5WsVstlE4TauZYacuyO",
                              service_name: "test",
                              active_version: 1,
                              customer_id: customer.id)

              result = Service.process_service(@service)

              service = Service.find_by(service_id: "4iF5WsVstlE4TauZYacuyO")

              expect(result).to eq true
              expect(service.service_id).to eq "4iF5WsVstlE4TauZYacuyO"
              expect(service.service_name).to eq "testing"
              expect(service.active_version).to eq 2
              expect(service.previous_version).to eq 1
            end
          end

          context "the active version is the same as the new version" do
            it "does not update the service and returns nil" do
              customer = Customer.create(customer_id: "6ARY9ZJiyoSmIXMwG16qw0",
                                          name: "Jonathan Foote")

              Service.create(service_id: "4iF5WsVstlE4TauZYacuyO",
                              service_name: "test",
                              active_version: 2,
                              customer_id: customer.id)

              result = Service.process_service(@service)

              service = Service.find_by(service_id: "4iF5WsVstlE4TauZYacuyO")

              expect(result).to be nil
              expect(service.service_name).to eq "test"
              expect(service.active_version).to eq 2
              expect(service.previous_version).to eq nil
            end
          end
        end

        context "it is a new service" do
          it "creates a new service" do
            expect(Service.count).to eq 0

            result = Service.process_service(@service)

            service = Service.find_by(service_id: "4iF5WsVstlE4TauZYacuyO")

            expect(result).to eq service
            expect(Service.count).to eq 1
            expect(service.service_name).to eq "testing"
            expect(service.active_version).to eq 2
            expect(service.previous_version).to eq nil
          end
        end
      end
    end
  end
end

require 'rails_helper'

describe Customer, type: :model do
  describe "attributes" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:customer_id) }
  end

  describe "relationships" do
    it { should have_many(:services) }
  end
end

class InitiatorsController < ApplicationController
  def index
    @services = Service.all.order(:updated_at).reverse
  end
end

class InitiatorsController < ApplicationController
  def index
    @services = Service.all.reverse
  end
end

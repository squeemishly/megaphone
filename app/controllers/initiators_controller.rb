class InitiatorsController < ApplicationController
  def index
    @services = Service.most_recent
  end
end

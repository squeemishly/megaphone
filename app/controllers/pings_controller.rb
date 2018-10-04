class PingsController < ApplicationController
  def index
    UpdatedServicesPinger.ping

    redirect_to root_path
  end
end

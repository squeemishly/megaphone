class PingsController < ApplicationController
  def index
    UpdateServices.update_services

    redirect_to root_path
  end
end

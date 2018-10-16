class PingsController < ApplicationController
  def index
    UpdateServices.update

    redirect_to root_path
  end
end

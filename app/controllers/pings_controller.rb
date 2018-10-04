class PingsController < ApplicationController
  def index
    @conn = Faraday.new('https://app.fastly.com/admin/changes?interval=60')

    resp = @conn.get do |req|
      req.headers["Fastly-key"] = ENV["fastly_api_key"]
    end

    JSON.parse(resp.body, symbolize_names: true)

    redirect_to root_path
  end
end

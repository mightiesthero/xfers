class HomeController < ApplicationController
  include ApplicationHelper

  def index
    @user = get_user

    address = "https://sandbox-id.xfers.com/api/v3/user/transfer_info"
    headers = api_header
    result = HTTParty.get address, headers: headers
    @transfers = JSON.parse result.body
  end
end

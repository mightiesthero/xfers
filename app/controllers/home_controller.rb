class HomeController < ApplicationController
  def index
    address = "https://sandbox-id.xfers.com/api/v3/user"
    headers = {
      "X-XFERS-APP-API-KEY" => "3dehFLadwsxNUWe_sSp5ymBaQJB8yLzPyM1sRgkTDPk",
      "X-XFERS-APP-API-SECRET" => "rGZUQrjtqUzRqwsSNk9G5z8yRxmYxguZzxkrNwJze1k"
    }
    result = HTTParty.get address, headers: headers
    @user = JSON.parse result.body

    address = "#{address}/transfer_info"
    result = HTTParty.get address, headers: headers
    @transfers = JSON.parse result.body
  end
end

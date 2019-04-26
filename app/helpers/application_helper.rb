module ApplicationHelper
  def api_header
    {
      "X-XFERS-APP-API-KEY" => "3dehFLadwsxNUWe_sSp5ymBaQJB8yLzPyM1sRgkTDPk",
      "X-XFERS-APP-API-SECRET" => "rGZUQrjtqUzRqwsSNk9G5z8yRxmYxguZzxkrNwJze1k"
    }
  end

  def get_user
    address = "https://sandbox-id.xfers.com/api/v3/user"
    headers = api_header
    result = HTTParty.get address, headers: headers
    JSON.parse result.body
  end
end

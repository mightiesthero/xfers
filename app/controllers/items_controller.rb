class ItemsController < ApplicationController
  def new
  end

  def create
    amount = count_amount
    items = build_items
    order_id = DateTime.now.strftime("%Y%m%d%H%M%S")
    notify_link = "#{my_host}"
    return_link = "#{my_host}"
    cancel_link = "#{my_host}"
    address = "https://sandbox-id.xfers.com/api/v3/charges"
    headers = {
      "X-XFERS-APP-API-KEY" => "3dehFLadwsxNUWe_sSp5ymBaQJB8yLzPyM1sRgkTDPk",
      "X-XFERS-APP-API-SECRET" => "rGZUQrjtqUzRqwsSNk9G5z8yRxmYxguZzxkrNwJze1k",
      "Content-Type" => "application/json"
    }
    body = {
      "amount" => amount,
      "currency" => "IDR",
      "notify_url" => notify_link,
      "return_url" => return_link,
      "cancel_url" => cancel_link,
      "order_id" => order_id,
      "redirect" => false,
      "description" => "unusedreddress",
      "shipping" => "2.50",
      "tax" => "0.0",
      "redirect" => false,
      "items" => items,
      "metadata" => {
        "firstname" => "Tianwei",
        "lastname" => "Liu"
      },
      "debit_only" => true
    }
    result = HTTParty.post(address, body: body.to_json, headers: headers)
    transaction = JSON.parse result.body

    redirect_to transaction["checkout_url"]
  end

  def count_amount
    amount = 0
    params["quantity"].each_with_index do |quantity, index|
      amount = amount + params["price"][index].to_f * quantity.to_f
    end
    amount
  end

  def build_items
    items = []
    params["quantity"].each_with_index do |quantity, index|
      qty = quantity.to_f
      if qty.to_f > 0
        item = {
          "quantity" => qty,
          "name" => params["name"][index],
          "price" => params["price"][index],
          "description" => params["description"][index]
        }
        items.push(item)
      end
    end
    items
  end

  def my_host
    "#{request.protocol}#{request.host_with_port}"
  end
end

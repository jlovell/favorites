require 'address_lookup'

class AddressesController < ApplicationController
  def fetch
    restaurant = Restaurant.find(params[:restaurant_id])
    result = AddressLookup.find(name: restaurant.name, city: params[:city])
    return render text: "Google couldn't find this one. Sorry!" unless result

    addr = Address.create_from_full(result, restaurant_id: restaurant.id)
    render text: addr.formatted_address
  end
end

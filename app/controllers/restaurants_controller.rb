class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.includes(:address).all.map do |r|
      data = r.attributes.slice(*%w(id name created_at)).symbolize_keys
      data.merge!(dish_count: r.dishes.count)
      data.merge!(address: r.formatted_address)
      data
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @dishes = @restaurant.dishes.includes(:ratings).map do |dish|
      { name: dish.name, rating: dish.ratings.first.value }
    end
  end
end

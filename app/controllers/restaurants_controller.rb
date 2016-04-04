class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all.map do |r|
      r.attributes.slice(*%w(id name created_at)).symbolize_keys
        .merge(dish_count: r.dishes.count)
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @dishes = @restaurant.dishes.includes(:ratings).map do |dish|
      { name: dish.name, rating: dish.ratings.first.value }
    end
  end
end

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

  def create
    r = Restaurant.create(restaurant_params)
    redirect_to restaurant_path(r)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end

class RestaurantsController < ApplicationController
  def index
    # FIXME this query -- single SQL call but ugly
    @restaurants = Restaurant.joins(:dishes).joins(:address)
      .group('restaurants.id, addresses.id')
      .select(:id,
              :name,
              :created_at,
              'count(dishes.id) as dish_count',
              "concat_ws(', ', addresses.address_1, addresses.city) as address")
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

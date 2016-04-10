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
    if current_user
      @your_dishes = Rating.for_restaurant(@restaurant).for_user(current_user).map do |rating|
        { name: rating.dish.name, rating: rating.value }
      end
    end
    @all_dishes = Rating.for_restaurant(@restaurant).not_for_user(current_user).map do |rating|
      { name: rating.dish.name, rating: rating.value }
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

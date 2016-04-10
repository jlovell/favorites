class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.with_dish_count.includes(:address).map do |r|
      r.attributes.symbolize_keys!.merge(address: r.formatted_address)
    end
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
    if (r = Restaurant.create(restaurant_params))
      redirect_to restaurant_path(r)
      flash[:success] = "Successfully created #{r.name}"
    else
      flash[:error] = "There was an error creating the new restaurant"
      redirect_to root_path
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end

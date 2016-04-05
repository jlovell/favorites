class DishesController < ApplicationController
  def new
    @restaurant = Restaurant.find params[:restaurant_id]
    @dish = @restaurant.dishes.new
    @rating = @dish.ratings.new
  end

  def create
    # todo validation errors
    dish = Dish.create!(dish_params)
    raise unless dish.ratings.first.value
    redirect_to restaurant_path(dish.category)
  end

  private

  def dish_params
    params.require(:dish).permit!
  end
end

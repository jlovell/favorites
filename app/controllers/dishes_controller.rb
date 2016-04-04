class DishesController < ApplicationController
  def new
    @restaurant = Restaurant.find params[:restaurant_id]
  end

  def create
    raise params.inspect
  end
end

class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all.map do |r|
      r.attributes.slice(%w(id name created_at)).symbolize_keys
        .merge(rating: r.calculate_rating)
    end
  end
end

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :dish
  # validates :dish, presence: true

  scope :for_restaurant, -> (restaurant) {
    where(dish_id: restaurant.dishes.select(:id))
  }

  def self.calculate_average
    average(:value)
  end
end

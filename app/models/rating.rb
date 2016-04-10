class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :dish
  # validates :dish, presence: true

  scope :for_restaurant, -> (restaurant) {
    where(dish_id: restaurant.dishes.select(:id))
  }

  scope :for_user, -> (user) { where(user_id: user.id) }
  scope :not_for_user, -> (user) {
    user ? where.not(user_id: user.id) : all
  }

  def self.calculate_average
    average(:value)
  end
end

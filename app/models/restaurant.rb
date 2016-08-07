class Restaurant < ActiveRecord::Base
  has_many :dishes, as: :category
  has_many :ratings, through: :dishes
  has_one :address, dependent: :destroy

  delegate :formatted_address, to: :address, allow_nil: true

  scope :with_dish_count, -> {
    left_join_dishes.group(:id)
      .select('restaurants.*',
        'count(dishes.id) as dish_count')
      .order('dish_count desc')
  }

  scope :left_join_dishes, -> {
    joins("LEFT JOIN dishes ON dishes.category_id = restaurants.id " \
          "AND dishes.category_type = 'Restaurant'")
  }

  def average_rating
    ratings.calculate_average
  end
end

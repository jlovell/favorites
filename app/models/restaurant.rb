class Restaurant < ActiveRecord::Base
  has_many :dishes, as: :category
  has_many :ratings, through: :dishes

  def average_rating
    ratings.calculate_average
  end
end

class Restaurant < ActiveRecord::Base
  has_many :items, as: :category
  has_many :ratings, through: :items

  def average_rating
    ratings.calculate_average
  end
end

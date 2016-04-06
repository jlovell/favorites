class Restaurant < ActiveRecord::Base
  has_many :dishes, as: :category
  has_many :ratings, through: :dishes
  has_one :address, dependent: :destroy

  delegate :formatted_address, to: :address, allow_nil: true

  def average_rating
    ratings.calculate_average
  end
end

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  validates :item, presence: true

  scope :for_restaurant, -> (restaurant) {
    where(item_id: restaurant.items.select(:id))
  }

  def self.calculate_average
    average(:value)
  end
end

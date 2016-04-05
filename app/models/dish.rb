class Dish < ActiveRecord::Base
  belongs_to :category, polymorphic: true
  validates :category, presence: true
  has_many :ratings, dependent: :destroy

  accepts_nested_attributes_for :ratings
end

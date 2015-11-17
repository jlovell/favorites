class Item < ActiveRecord::Base
  belongs_to :category, polymorphic: true
  validates :category, presence: true
  has_many :ratings
end

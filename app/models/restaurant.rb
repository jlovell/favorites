class Restaurant < ActiveRecord::Base
  has_many :items, as: :category
end

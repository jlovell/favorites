class Item < ActiveRecord::Base
  belongs_to :category, polymorphic: true
end

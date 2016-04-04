data = YAML.load_file("etc/seeds.yml")

data.each do |restaurant_data|
  rest = Restaurant.where(name: restaurant_data[:restaurant]).first_or_create!
  restaurant_data[:dishes].each do |dish_data|
    dish = rest.dishes.where(name: dish_data[:name]).first_or_create!
    dish.ratings.where(value: dish_data[:rating]).first_or_create!
  end
end

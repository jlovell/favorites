namespace :data_population do
  desc "Populate the original favorites list to the DB"
  task :load_all => :environment do
    data = YAML.load_file("etc/full_data.yml")

    data.each do |restaurant_data|
      rest_name = restaurant_data.fetch(:restaurant)
      puts rest_name
      rest = Restaurant.where(name: rest_name).first_or_create!

      if rest_address = restaurant_data[:address]
        puts rest_address
        rest.create_address!(Address.parts_from_full(rest_address))
      end

      restaurant_data.fetch(:dishes).each do |dish_data|
        dish_name   = dish_data.fetch(:name)
        dish_rating = dish_data.fetch(:rating)
        puts "  #{dish_name} => #{dish_rating}"

        dish = rest.dishes.where(name: dish_name).first_or_create!
        dish.ratings.where(value:dish_rating).first_or_create!
      end
    end
  end

  desc "Clear all restaurant and dish data -- should not be used in production"
  task :clear_all => :environment do
    [Restaurant, Dish, Rating].each(&:destroy_all)
  end

  desc "Reset all data to the original favorites list"
  task :reset => [:clear_all, :load_all]
end

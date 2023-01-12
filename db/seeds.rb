# require 'csv'
# require 'json'
# require "open-uri"

# puts 'Cleaning database'
# DishIngredient.destroy_all
# AllergyProfile.destroy_all
# Diet.destroy_all
# Intolerance.destroy_all
# Ingredient.destroy_all
# MenuDish.destroy_all
# Dish.destroy_all
# DayMenu.destroy_all
# WeekMenu.destroy_all
# Profile.destroy_all
# School.destroy_all
# User.destroy_all

# # USER
#   puts 'Creating user'

#   dietitian = User.create!(first_name: 'Grace', last_name: 'Allmark', email: 'ga@gmail.com', password: '123123')

# # SCHOOLS
#   puts 'Creating schools'

#   @cheam = School.create!(name: 'Cheam', town: 'Newbury', postcode: 'RG19 8LD', menu_count: 10, user: dietitian)
#   file = URI.open('http://res.cloudinary.com/df5d4fbx4/image/upload/v1/development/v1t9h5nmvhg542shwu3j3966i3q5')
#   @cheam.photo.attach(io: file, filename: 'cheam.jpg', content_type: 'image/jpg')
#   @cheam.save

#   @eton = School.create!(name: 'Eton', town: 'Windsor', postcode: 'SL4 6DW', menu_count: 10, user: dietitian)
#   file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669285266/ug7wnbkxu1borfrnv4w8.jpg')
#   @eton.photo.attach(io: file, filename: 'eton.jpg', content_type: 'image/jpg')
#   @eton.save

#   @hogwarts = School.create!(name: 'Hogwarts', town: 'Hogsmeade', postcode: 'CH16 1DE', menu_count: 10, user: dietitian)
#   file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669283546/mbehaazckdwyrz7txvtj.jpg')
#   @hogwarts.photo.attach(io: file, filename: 'hogwarts.jpg', content_type: 'image/jpg')
#   @hogwarts.save

#   @bsb = School.create!(name: 'BSB', town: 'Bournemouth', postcode: 'BH8 9PY', menu_count: 10, user: dietitian)
#   file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669285048/uw5wxfx7jgimvkm8i1lz.jpg')
#   @bsb.photo.attach(io: file, filename: 'bsb.jpg', content_type: 'image/jpg')
#   @bsb.save

#   @st_trinians = School.create!(name: 'St Trinians', town: 'Remenham', postcode: 'RG9 3DD', menu_count: 14, user: dietitian)
#   file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669285062/lej4phekj0rlueypqpsv.jpg')
#   @st_trinians.photo.attach(io: file, filename: 'st_trinians.jpg', content_type: 'image/jpg')
#   @st_trinians.save

#   @kings = School.create!(name: 'Kings', town: 'Winchester', postcode: 'SO22 5PN', menu_count: 4, user: dietitian)
#   file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669726023/rfqojlnjwiyttmu5qv0a.png')
#   @kings.photo.attach(io: file, filename: 'kings.jpg', content_type: 'image/jpg')
#   @kings.save

# # DIETS
#   puts 'Creating diets'

#   ["Gluten Free", "Ketogenic", "Vegetarian", "Lacto-Vegetarian", "Ovo-Vegetarian", "Vegan", "Pescetarian", "Paleo", "Primal", "Low FODMAP", "Whole30"].each do |diet|
#     Diet.create(name: diet)
#   end



# # INTOLERANCES
#   puts 'Creating intolerances'

#   ["Dairy", "Egg", "Gluten", "Grain", "Peanut", "Seafood", "Sesame", "Shellfish", "Soy", "Sulfite", "Tree Nut", "Wheat"].each do |intolerance|
#     Intolerance.create(name: intolerance)
#   end


# # INGREDIENTS
#   puts 'Creating ingredients'

#   filepath = "db/data/ingredients.csv"
#   CSV.foreach(filepath, headers: :first_row, col_sep: ';') do |row|
#     Ingredient.create!(name: row[0], id: row[1])
#   end

# # DISHES
#   puts 'Creating dishes'
#   # main course
#   Dish.create(name:"Jade Buddha Salmon Tartare", course:"main course")
#   Dish.create(name:"Shredded Roast Beef Stuffed Sweet Potatoes", course:"main course")
#   Dish.create(name:"Roasted Endive Salad With Prosciutto, Figs and Pistachios", course:"main course")
#   Dish.create(name:"Split Pea and Mushroom Soup", course:"main course")
#   Dish.create(name:"Alouette Chicken Paprika", course:"main course")
#   Dish.create(name:"Bacon Wrapped Pork Tenderloin", course:"main course")
#   Dish.create(name:"Salmon, Watercress, Fennel and Baby Beetroot Salad With Lemony Caviar Dressing", course:"main course")
#   Dish.create(name:"Cilantro Lime Halibut", course:"main course")
#   Dish.create(name:"Brown Butter Twice Baked Sweet Potatoes", course:"main course")
#   Dish.create(name:"Chimichurri Skirt Steak with Grilled Asparagus", course:"main course")

#   #sides
#   Dish.create(name:"Garlicky Kale", course:"side dish")
#   Dish.create(name:"Cauliflower, Brown Rice, and Vegetable Fried Rice", course:"side dish")
#   Dish.create(name:"Powerhouse Almond Matcha Superfood Smoothie", course:"side dish")
#   Dish.create(name:"Farro With Mushrooms and Asparagus", course:"side dish")
#   Dish.create(name:"Corn Avocado Salsa", course:"side dish")
#   Dish.create(name:"Moroccan Couscous and Chickpea Salad", course:"side dish")
#   Dish.create(name:"Swiss Chard Wraps", course:"side dish")
#   Dish.create(name:"Spicy Indian-Style Hummus", course:"side dish")
#   Dish.create(name:"Balsamic Roasted Vegetables", course:"side dish")
#   Dish.create(name:"Doughnuts", course:"side dish")

#   #dessert
#   Dish.create(name:"Vegan Dirty Chai Pudding", course:"dessert")
#   Dish.create(name:"Mango Cranberry Sherbet", course:"dessert")
#   Dish.create(name:"Strawberry Cheesecake Chocolate Crepes", course:"dessert")
#   Dish.create(name:"Coffee Chia Pudding", course:"dessert")
#   Dish.create(name:"Mint Chocolate Chia Pudding", course:"dessert")
#   Dish.create(name:"Strawberry Lime Basil Sherbet", course:"dessert")
#   Dish.create(name:"Easy Strawberry Shortcake", course:"dessert")
#   Dish.create(name:"Avocado Chocolate Bits Frozen Yogurt", course:"dessert")
#   Dish.create(name:"Cherries and Yogurt Parfait", course:"dessert")
#   Dish.create(name:"Chocolate Pudding", course:"dessert")

# # PROFILES
#   puts 'Creating profiles'

#   School.all.each do |school|
#     @profile_1_school = Profile.create(school: school, diet: Diet.all.sample)
#     @profile_2_school = Profile.create(school: school, diet: Diet.all.sample)
#   end


# # DISH INGREDIENTS (join_table)

# # # WEEK_MENUS + ALLERGY PROFILES (join table)
#     puts 'Creating allergy profiles'
#     puts 'Creating week menus'
#   Profile.all.each do |profile|
#     @allergy_profile_1_profile = AllergyProfile.create(profile: profile, ingredient: Ingredient.all.sample)
#     @allergy_profile_2_profile = AllergyProfile.create(profile: profile, ingredient: Ingredient.all.sample)
#     intolerance_profile_1_profile = IntoleranceProfile.create(profile: profile, intolerance: Intolerance.all.sample)
#     intolerance_profile_2_profile = IntoleranceProfile.create(profile: profile, intolerance: Intolerance.all.sample)
#     @week_menu_dec26_allergy_profile = WeekMenu.create(date: Date.new(2022, 12, 26), profile: profile)
#     @week_menu_dec5_allergy_profile = WeekMenu.create(date: Date.new(2022, 12, 5), profile: profile)
#   end
#   # @allergy_profile_pineapple_pinenuts_pineapple = AllergyProfile.create(profile: @profile_pineapple_pinenuts, ingredient: Ingredient.find_by(id: 9266))
#   # @allergy_profile_pineapple_pinenuts_peanuts = AllergyProfile.create(profile: @profile_pineapple_pinenuts, ingredient: Ingredient.find_by(id: 16091))

#   # @allergy_profile_tomatoes_walnuts_tomatoes = AllergyProfile.create(profile: @profile_tomatoes_walnuts, ingredient: Ingredient.find_by(id: 11529))
#   # @allergy_profile_tomatoes_walnuts_walnuts = AllergyProfile.create(profile: @profile_tomatoes_walnuts, ingredient: Ingredient.find_by(id: 12155))

# # DAY MENUS
#   puts 'Creating day menus'

#   WeekMenu.all.each do |week_menu|
#     (week_menu.date..week_menu.date+4.days).each do |day|
#       @week_menu_day = DayMenu.create(date: day, week_menu: week_menu)
#     end
#   end

# # MENU DISHES (join table)
#   puts 'Creating dishes for each menu'
#   DayMenu.all.each do |day_menu|
#     dish_day_menu = MenuDish.create(day_menu: day_menu, dish: Dish.where(course: "main course").sample)
#     dish_day_menu = MenuDish.create(day_menu: day_menu, dish: Dish.where(course: "side dish").sample)
#     dish_day_menu = MenuDish.create(day_menu: day_menu, dish: Dish.where(course: "dessert").sample)
#   end


#   # # Tomatoes_walnuts
# #     # Week 1
# # @day_menu_tomatoes_walnuts_dec_26_mon = DayMenu.create(date: Date.new(2022,12,26), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # @day_menu_tomatoes_walnuts_dec_26_tue = DayMenu.create(date: Date.new(2022,12,27), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # @day_menu_tomatoes_walnuts_dec_26_wed = DayMenu.create(date: Date.new(2022,12,28), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # @day_menu_tomatoes_walnuts_dec_26_thu = DayMenu.create(date: Date.new(2022,12,29), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # @day_menu_tomatoes_walnuts_dec_26_fri = DayMenu.create(date: Date.new(2022,12,30), week_menu: @week_menu_tomatoes_walnuts_dec26)
# #     # Week 2
# # # @day_menu_tomatoes_walnuts_dec_26_mon = DayMenu.create(date: Date.new(2023,01,02), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # # @day_menu_tomatoes_walnuts_dec_26_tue = DayMenu.create(date: Date.new(2023,01,03), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # # @day_menu_tomatoes_walnuts_dec_26_wed = DayMenu.create(date: Date.new(2023,01,04), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # # @day_menu_tomatoes_walnuts_dec_26_thu = DayMenu.create(date: Date.new(2023,01,05), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # # @day_menu_tomatoes_walnuts_dec_26_fri = DayMenu.create(date: Date.new(2023,01,06), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # #   # Week 3
# # # @day_menu_tomatoes_walnuts_dec_26_mon = DayMenu.create(date: Date.new(2023,01,09), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # # @day_menu_tomatoes_walnuts_dec_26_tue = DayMenu.create(date: Date.new(2023,01,10), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # # @day_menu_tomatoes_walnuts_dec_26_wed = DayMenu.create(date: Date.new(2023,01,11), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # # @day_menu_tomatoes_walnuts_dec_26_thu = DayMenu.create(date: Date.new(2023,01,12), week_menu: @week_menu_tomatoes_walnuts_dec26)
# # # @day_menu_tomatoes_walnuts_dec_26_fri = DayMenu.create(date: Date.new(2023,01,13), week_menu: @week_menu_tomatoes_walnuts_dec26)

# # # Pineapple_pinenuts

# #   # Week 1
# # @day_menu_pineapple_pinenuts_dec_26_mon = DayMenu.create(date: Date.new(2022,12,26), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # @day_menu_pineapple_pinenuts_dec_26_tue = DayMenu.create(date: Date.new(2022,12,27), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # @day_menu_pineapple_pinenuts_dec_26_wed = DayMenu.create(date: Date.new(2022,12,28), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # @day_menu_pineapple_pinenuts_dec_26_thu = DayMenu.create(date: Date.new(2022,12,29), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # @day_menu_pineapple_pinenuts_dec_26_fri = DayMenu.create(date: Date.new(2022,12,30), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # # Week 2
# # # @day_menu_pineapple_pinenuts_dec_26_mon = DayMenu.create(date: Date.new(2023,01,02), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # # @day_menu_pineapple_pinenuts_dec_26_tue = DayMenu.create(date: Date.new(2023,01,03), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # # @day_menu_pineapple_pinenuts_dec_26_wed = DayMenu.create(date: Date.new(2023,01,04), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # # @day_menu_pineapple_pinenuts_dec_26_thu = DayMenu.create(date: Date.new(2023,01,05), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # # @day_menu_pineapple_pinenuts_dec_26_fri = DayMenu.create(date: Date.new(2023,01,06), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # #   # Week 3
# # # @day_menu_pineapple_pinenuts_dec_26_mon = DayMenu.create(date: Date.new(2023,01,09), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # # @day_menu_pineapple_pinenuts_dec_26_tue = DayMenu.create(date: Date.new(2023,01,10), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # # @day_menu_pineapple_pinenuts_dec_26_wed = DayMenu.create(date: Date.new(2023,01,11), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # # @day_menu_pineapple_pinenuts_dec_26_thu = DayMenu.create(date: Date.new(2023,01,12), week_menu: @week_menu_pineapple_pinenuts_dec26)
# # # @day_menu_pineapple_pinenuts_dec_26_fri = DayMenu.create(date: Date.new(2023,01,13), week_menu: @week_menu_pineapple_pinenuts_dec26)

# # # (Date.new(2022,12,26)..Date.new(2023,01,13)).each do |date|
# # #   @day_menu_tomatoes_walnuts_dec_26_"#{date.strftime("%a %d")}" = DayMenu.create(date: date, week_menu: @week_menu_tomatoes_walnuts_dec26)
# # # end

# # # (Date.new(2022,12,26)..Date.new(2023,01,13)).each do |date|
# # #   @day_menu_pineapple_pinenuts_dec_26_"#{date.strftime("%a %d")}" = DayMenu.create(date: date, week_menu: @week_menu_pineapple_pinenuts_dec26)
# # # end


# # # # MENU DISHES (join table)

# # # @menu_dishes_tomatoes_walnuts_dec_26_mon
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_mon, dish: Dish.where(course: "main course").sample)
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_mon, dish: Dish.where(course: "side dish").sample)
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_mon, dish: Dish.where(course: "dessert").sample)

# # # @menu_dishes_tomatoes_walnuts_dec_26_tue
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_tue, dish: Dish.where(course: "main course").sample)
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_tue, dish: Dish.where(course: "side dish").sample)
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_tue, dish: Dish.where(course: "dessert").sample)

# # # @menu_dishes_tomatoes_walnuts_dec_26_wed
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_wed, dish: Dish.where(course: "main course").sample)
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_wed, dish: Dish.where(course: "side dish").sample)
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_wed, dish: Dish.where(course: "dessert").sample)

# # # @menu_dishes_tomatoes_walnuts_dec_26_thu
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_thu, dish: Dish.where(course: "side dish").sample)
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_thu, dish: Dish.where(course: "dessert").sample)
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_thu, dish: Dish.where(course: "main course").sample)

# # # @menu_dishes_tomatoes_walnuts_dec_26_fri
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_fri, dish: Dish.where(course: "main course").sample)
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_fri, dish: Dish.where(course: "side dish").sample)
# # MenuDish.create(day_menu: @day_menu_tomatoes_walnuts_dec_26_fri, dish: Dish.where(course: "dessert").sample)

puts "setting profile status"

# Profile.all.each do |profile|
#   profile.active = true
#   profile.save
#   pp profile.active?
# end

@false_profile = Profile.where(school: School.find(1)).sample
@false_profile.active = false
@false_profile.save

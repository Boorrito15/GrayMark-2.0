require 'csv'
require 'json'
require "open-uri"

puts 'Cleaning database'
# DishIngredient.destroy_all
# AllergyProfile.destroy_all
# Ingredient.destroy_all
# MenuDish.destroy_all
# Dish.destroy_all
# DayMenu.destroy_all
# WeekMenu.destroy_all
# Profile.destroy_all
# School.destroy_all
# User.destroy_all

puts 'Creating Ingredient List'

# # USER

# dietitian = User.create!(first_name: 'Grace', last_name: 'Allmark', email: 'ga@gmail.com', password: '123123')

# # SCHOOLS

# cheam = School.create!(name: 'Cheam', town: 'Newbury', postcode: 'RG19 8LD', menu_count: 10, user: dietitian)
# file = URI.open('http://res.cloudinary.com/df5d4fbx4/image/upload/v1/development/v1t9h5nmvhg542shwu3j3966i3q5')
# cheam.photo.attach(io: file, filename: 'cheam.jpg', content_type: 'image/jpg')
# cheam.save

# eton = School.create!(name: 'Eton', town: 'Windsor', postcode: 'SL4 6DW', menu_count: 10, user: dietitian)
# file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669285266/ug7wnbkxu1borfrnv4w8.jpg')
# eton.photo.attach(io: file, filename: 'eton.jpg', content_type: 'image/jpg')
# eton.save

# hogwarts = School.create!(name: 'Hogwarts', town: 'Hogsmeade', postcode: 'CH16 1DE', menu_count: 10, user: dietitian)
# file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669283546/mbehaazckdwyrz7txvtj.jpg')
# hogwarts.photo.attach(io: file, filename: 'hogwarts.jpg', content_type: 'image/jpg')
# hogwarts.save

# bsb = School.create!(name: 'BSB', town: 'Bournemouth', postcode: 'BH8 9PY', menu_count: 10, user: dietitian)
# file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669285048/uw5wxfx7jgimvkm8i1lz.jpg')
# bsb.photo.attach(io: file, filename: 'bsb.jpg', content_type: 'image/jpg')
# bsb.save

# st_trinians = School.create!(name: 'St Trinians', town: 'Remenham', postcode: 'RG9 3DD', menu_count: 14, user: dietitian)
# file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669285062/lej4phekj0rlueypqpsv.jpg')
# st_trinians.photo.attach(io: file, filename: 'st_trinians.jpg', content_type: 'image/jpg')
# st_trinians.save

# kings = School.create!(name: 'Kings', town: 'Winchester', postcode: 'SO22 5PN', menu_count: 4, user: dietitian)
# file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669726023/rfqojlnjwiyttmu5qv0a.png')
# kings.photo.attach(io: file, filename: 'kings.jpg', content_type: 'image/jpg')
# kings.save

# # INGREDIENTS

# filepath = "db/data/ingredients.csv"

# CSV.foreach(filepath, headers: :first_row, col_sep: ';') do |row|
#   Ingredient.create!(name: row[0], id: row[1])
# end

# # PROFILES
# @cheam = School.find_by(name: "Cheam")

# @profile_tomatoes_walnuts = Profile.create(school: @cheam)
# @profile_pineapple_pinenuts = Profile.create(school: @cheam)

# # # ALLERGY PROFILES

# @allergy_profile_pineapple_pinenuts_pineapple = AllergyProfile.create(profile: @profile_pineapple_pinenuts, ingredient: Ingredient.find_by(id: 9266))
# @allergy_profile_pineapple_pinenuts_peanuts = AllergyProfile.create(profile: @profile_pineapple_pinenuts, ingredient: Ingredient.find_by(id: 16091))

# @allergy_profile_tomatoes_walnuts_tomatoes = AllergyProfile.create(profile: @profile_tomatoes_walnuts, ingredient: Ingredient.find_by(id: 11529))
# @allergy_profile_tomatoes_walnuts_walnuts = AllergyProfile.create(profile: @profile_tomatoes_walnuts, ingredient: Ingredient.find_by(id: 12155))

# pp @profile_tomatoes_walnuts.allergy_profile
# pp @profile_pineapple_pinenuts.allergy_profile

# # WEEK_MENUS

# @week_menu_dec26_tomatoes_walnuts = WeekMenu.create(date: Date.new(2022,12,26), profile: Profile.first)
# @week_menu_dec26_pineapple_pinenuts = WeekMenu.create(date: Date.new(2022,12,26), profile: Profile.second)

@week_menu_dec5_tomatoes_walnuts = WeekMenu.create(date: Date.new(2022,12,5), profile: Profile.first)
@week_menu_dec5_pineapple_pinenuts = WeekMenu.create(date: Date.new(2022,12,5), profile: Profile.second)

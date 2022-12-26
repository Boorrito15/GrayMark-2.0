require 'csv'
require 'json'
require "open-uri"

puts 'Cleaning database'
DishIngredient.destroy_all
AllergyProfile.destroy_all
Ingredient.destroy_all
MenuDish.destroy_all
Dish.destroy_all
DayMenu.destroy_all
WeekMenu.destroy_all
Profile.destroy_all
School.destroy_all
User.destroy_all

puts 'Creating Ingredient List'

dietitian = User.create!(first_name: 'Grace', last_name: 'Allmark', email: 'ga@gmail.com', password: '123123')

cheam = School.create!(name: 'Cheam', town: 'Newbury', postcode: 'RG19 8LD', menu_count: 10, user: dietitian)
file = URI.open('http://res.cloudinary.com/df5d4fbx4/image/upload/v1/development/v1t9h5nmvhg542shwu3j3966i3q5')
cheam.photo.attach(io: file, filename: 'cheam.jpg', content_type: 'image/jpg')
cheam.save

eton = School.create!(name: 'Eton', town: 'Windsor', postcode: 'SL4 6DW', menu_count: 10, user: dietitian)
file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669285266/ug7wnbkxu1borfrnv4w8.jpg')
eton.photo.attach(io: file, filename: 'eton.jpg', content_type: 'image/jpg')
eton.save

hogwarts = School.create!(name: 'Hogwarts', town: 'Hogsmeade', postcode: 'CH16 1DE', menu_count: 10, user: dietitian)
file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669283546/mbehaazckdwyrz7txvtj.jpg')
hogwarts.photo.attach(io: file, filename: 'hogwarts.jpg', content_type: 'image/jpg')
hogwarts.save

bsb = School.create!(name: 'BSB', town: 'Bournemouth', postcode: 'BH8 9PY', menu_count: 10, user: dietitian)
file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669285048/uw5wxfx7jgimvkm8i1lz.jpg')
bsb.photo.attach(io: file, filename: 'bsb.jpg', content_type: 'image/jpg')
bsb.save

st_trinians = School.create!(name: 'St Trinians', town: 'Remenham', postcode: 'RG9 3DD', menu_count: 14, user: dietitian)
file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669285062/lej4phekj0rlueypqpsv.jpg')
st_trinians.photo.attach(io: file, filename: 'st_trinians.jpg', content_type: 'image/jpg')
st_trinians.save

kings = School.create!(name: 'Kings', town: 'Winchester', postcode: 'SO22 5PN', menu_count: 4, user: dietitian)
file = URI.open('https://res.cloudinary.com/df5d4fbx4/image/upload/v1669726023/rfqojlnjwiyttmu5qv0a.png')
kings.photo.attach(io: file, filename: 'kings.jpg', content_type: 'image/jpg')
kings.save

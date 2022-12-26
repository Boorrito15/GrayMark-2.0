# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_26_092804) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allergy_profiles", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_allergy_profiles_on_ingredient_id"
    t.index ["profile_id"], name: "index_allergy_profiles_on_profile_id"
  end

  create_table "day_menus", force: :cascade do |t|
    t.date "date"
    t.bigint "week_menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["week_menu_id"], name: "index_day_menus_on_week_menu_id"
  end

  create_table "dish_ingredients", force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_dish_ingredients_on_dish_id"
    t.index ["ingredient_id"], name: "index_dish_ingredients_on_ingredient_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.string "course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_dishes", force: :cascade do |t|
    t.bigint "day_menu_id", null: false
    t.bigint "dish_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_menu_id"], name: "index_menu_dishes_on_day_menu_id"
    t.index ["dish_id"], name: "index_menu_dishes_on_dish_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_profiles_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "town"
    t.string "postcode"
    t.integer "menu_count"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_schools_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "week_menus", force: :cascade do |t|
    t.date "date"
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_week_menus_on_profile_id"
  end

  add_foreign_key "allergy_profiles", "ingredients"
  add_foreign_key "allergy_profiles", "profiles"
  add_foreign_key "day_menus", "week_menus"
  add_foreign_key "dish_ingredients", "dishes"
  add_foreign_key "dish_ingredients", "ingredients"
  add_foreign_key "menu_dishes", "day_menus"
  add_foreign_key "menu_dishes", "dishes"
  add_foreign_key "profiles", "schools"
  add_foreign_key "schools", "users"
  add_foreign_key "week_menus", "profiles"
end

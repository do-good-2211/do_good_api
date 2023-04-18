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

ActiveRecord::Schema[7.0].define(version: 2023_04_18_023154) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "good_deeds", force: :cascade do |t|
    t.string "name"
    t.integer "host_id"
    t.date "date"
    t.time "time"
    t.string "notes"
    t.string "media_link"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_good_deeds", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "good_deed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_deed_id"], name: "index_user_good_deeds_on_good_deed_id"
    t.index ["user_id"], name: "index_user_good_deeds_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "provider"
  end

  add_foreign_key "user_good_deeds", "good_deeds"
  add_foreign_key "user_good_deeds", "users"
end

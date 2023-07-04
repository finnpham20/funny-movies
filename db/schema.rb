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

ActiveRecord::Schema[7.0].define(version: 2023_07_02_102003) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "youtube_url", limit: 500, null: false
    t.string "video_id", limit: 256
    t.string "title", limit: 1000
    t.integer "status", default: 0
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_posts_on_title"
    t.index ["user_id"], name: "index_posts_on_user_id"
    t.index ["video_id", "user_id"], name: "index_posts_video_user_uniqueness", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 256, null: false
    t.string "password_digest", limit: 256, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_06_063050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estoques", force: :cascade do |t|
    t.datetime "data"
    t.integer "quantidade"
    t.string "tipo"
    t.string "produto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lanchonetes", force: :cascade do |t|
    t.string "item"
    t.decimal "preco"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_uid"
    t.string "image_name"
    t.string "slug"
    t.index ["slug"], name: "index_lanchonetes_on_slug", unique: true
  end

  create_table "talks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "artist_id"
    t.string "image_uid"
    t.string "image_name"
    t.index ["artist_id"], name: "index_talks_on_artist_id"
    t.index ["slug"], name: "index_talks_on_slug", unique: true
  end

  create_table "talks_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "talk_id", null: false
    t.index ["talk_id", "user_id"], name: "index_talks_users_on_talk_id_and_user_id"
    t.index ["user_id", "talk_id"], name: "index_talks_users_on_user_id_and_talk_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "sobrenome", default: "", null: false
    t.string "usuario", default: "", null: false
    t.string "role", default: "comum", null: false
    t.string "phone", default: "", null: false
    t.string "cpf", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "talks", "artists"
end

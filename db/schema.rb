# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_29_034740) do

  create_table "friendships", force: :cascade do |t|
    t.integer "member_a_id", null: false
    t.integer "member_b_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_a_id"], name: "index_friendships_on_member_a_id"
    t.index ["member_b_id"], name: "index_friendships_on_member_b_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "url"
    t.string "code"
    t.integer "member_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_links_on_member_id"
  end

  create_table "member_topics", force: :cascade do |t|
    t.integer "member_id"
    t.integer "topic_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_member_topics_on_member_id"
    t.index ["topic_id"], name: "index_member_topics_on_topic_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "password_digest"
    t.string "website_address"
    t.string "website_short_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "friendships", "members", column: "member_a_id"
  add_foreign_key "friendships", "members", column: "member_b_id"
end

# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131211174838) do

  create_table "domain_rules", force: true do |t|
    t.string   "url"
    t.text     "good_rules"
    t.text     "bad_rules"
    t.text     "string_rules"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domain_rules", ["url"], name: "index_domain_rules_on_url", unique: true

  create_table "posts", force: true do |t|
    t.string   "url"
    t.text     "html"
    t.text     "f_html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["url"], name: "index_posts_on_url", unique: true

  create_table "scrapers", force: true do |t|
    t.string   "url"
    t.text     "html_head"
    t.text     "html_body"
    t.text     "bad_rules"
    t.text     "good_rules"
    t.text     "mod_html"
    t.string   "new"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

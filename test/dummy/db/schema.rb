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

ActiveRecord::Schema.define(version: 20160511142552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "devx_articles", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "short_description"
    t.text     "content"
    t.string   "image"
    t.datetime "published_at"
    t.datetime "approved_at"
    t.integer  "approved_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "devx_articles", ["published_at"], name: "index_devx_articles_on_published_at", using: :btree

  create_table "devx_authorizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_brandings", force: :cascade do |t|
    t.string   "company_name"
    t.string   "logo"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "devx_events", force: :cascade do |t|
    t.integer  "venue_id"
    t.string   "name"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "contact_name"
    t.string   "contact_email"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "devx_layout_stylesheets", force: :cascade do |t|
    t.integer  "layout_id"
    t.integer  "stylesheet_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "devx_layouts", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_media", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_page_stylesheets", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "stylesheet_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "devx_pages", force: :cascade do |t|
    t.integer  "layout_id"
    t.string   "name"
    t.string   "slug"
    t.string   "content"
    t.boolean  "is_home"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_sections", force: :cascade do |t|
    t.integer  "page_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_slides", force: :cascade do |t|
    t.integer  "slideshow_id"
    t.string   "title"
    t.string   "content"
    t.string   "image"
    t.integer  "position"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "devx_slideshows", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_stylesheets", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "devx_stylesheets", ["slug"], name: "index_devx_stylesheets_on_slug", using: :btree

  create_table "devx_transactions", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "payment_method"
    t.float    "amount"
    t.text     "comments"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "devx_users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "deleted_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "devx_users", ["deleted_at"], name: "index_devx_users_on_deleted_at", using: :btree
  add_index "devx_users", ["email"], name: "index_devx_users_on_email", unique: true, using: :btree
  add_index "devx_users", ["reset_password_token"], name: "index_devx_users_on_reset_password_token", unique: true, using: :btree
  add_index "devx_users", ["unlock_token"], name: "index_devx_users_on_unlock_token", unique: true, using: :btree

  create_table "devx_venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

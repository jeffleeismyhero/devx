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

ActiveRecord::Schema.define(version: 20161020212533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

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

  create_table "devx_account_transactions", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "transaction_type"
    t.string   "payment_method"
    t.float    "amount"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "store_id"
    t.string   "receipt_number"
    t.string   "upc"
    t.string   "product"
    t.string   "cardholder"
    t.datetime "processed_at"
    t.boolean  "imported"
  end

  create_table "devx_alumnis", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "prefix"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "suffix"
    t.string   "nickname"
    t.date     "birthdate"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.string   "phone"
    t.string   "marital_status"
    t.string   "linked_in"
    t.integer  "graduation_year"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "photo"
    t.string   "undergraduate"
    t.string   "degree_ug"
    t.string   "graduate"
    t.string   "degree_grad"
    t.string   "gender"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "employer"
    t.string   "industry"
    t.string   "position"
    t.string   "employer_address"
    t.string   "employer_city"
    t.string   "employer_state"
    t.integer  "employer_zip"
  end

  create_table "devx_announcements", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_application_settings", force: :cascade do |t|
    t.text     "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_article_galleries", force: :cascade do |t|
    t.integer  "article_id"
    t.string   "file"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_article_media", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "medium_id"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_article_subscriptions", force: :cascade do |t|
    t.string   "category"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_articles", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "short_description"
    t.text     "content"
    t.string   "image"
    t.datetime "published_at"
    t.datetime "approved_at"
    t.integer  "approved_by"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "user_id"
    t.string   "document"
    t.boolean  "featured",          default: false
    t.datetime "featured_until"
  end

  add_index "devx_articles", ["published_at"], name: "index_devx_articles_on_published_at", using: :btree

  create_table "devx_attendances", force: :cascade do |t|
    t.integer  "registration_id"
    t.integer  "child_id"
    t.datetime "check_in"
    t.datetime "check_out"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "devx_authorizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_brandings", force: :cascade do |t|
    t.string   "company_name"
    t.string   "logo"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "alternate_logo"
    t.string   "favicon"
    t.string   "primary_color"
    t.string   "secondary_color"
    t.string   "accent_color_1"
    t.string   "accent_color_2"
    t.string   "accent_color_3"
    t.string   "site_name"
    t.string   "address"
    t.string   "facebook"
    t.string   "twitter"
  end

  create_table "devx_calendar_subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "calendar_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "devx_calendars", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "google_calendar_id"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "calendar_type"
    t.string   "authorization_url"
    t.string   "authorization_code"
    t.string   "refresh_token"
    t.string   "time_zone"
    t.string   "slug"
    t.text     "embed_code"
  end

  create_table "devx_child_registrations", force: :cascade do |t|
    t.integer  "registration_id"
    t.integer  "child_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "devx_children", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_class_announcements", force: :cascade do |t|
    t.integer  "classroom_id"
    t.string   "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "devx_class_documents", force: :cascade do |t|
    t.integer  "classroom_id"
    t.string   "name"
    t.string   "filename"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "devx_class_galleries", force: :cascade do |t|
    t.integer  "classroom_id"
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "devx_class_highlights", force: :cascade do |t|
    t.integer  "classroom_id"
    t.string   "title"
    t.string   "content"
    t.string   "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "devx_class_photos", force: :cascade do |t|
    t.integer  "class_gallery_id"
    t.string   "name"
    t.string   "caption"
    t.string   "filename"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "devx_class_schedules", force: :cascade do |t|
    t.integer  "classroom_id"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "day_of_week",        default: [],              array: true
    t.integer  "classroom_teachers"
  end

  create_table "devx_classroom_custom_tabs", force: :cascade do |t|
    t.integer  "classroom_id"
    t.string   "tab_name"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "devx_classroom_teachers", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "classroom_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "bio"
  end

  create_table "devx_classrooms", force: :cascade do |t|
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.text     "welcome_message"
    t.text     "policies_and_procedures"
    t.string   "slug"
    t.string   "name"
    t.integer  "layout_id"
    t.boolean  "active"
    t.string   "highlight_tab_name",               default: "Highlights"
    t.string   "schedule_tab_name",                default: "Schedule"
    t.string   "policies_and_procedures_tab_name", default: "Policies and Procedures"
  end

  create_table "devx_contact_submissions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "subject"
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_documents", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_donations", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "amount"
    t.string   "cardholder_first_name"
    t.string   "cardholder_last_name"
    t.string   "billing_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "phone_number"
    t.string   "affiliation"
    t.boolean  "class_participation"
    t.boolean  "in_memorium"
    t.string   "dedicated_to"
    t.string   "email_to_notify"
    t.boolean  "company_match"
    t.string   "company_name"
    t.string   "company_email_to_notify"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "designation"
  end

  create_table "devx_event_subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_events", force: :cascade do |t|
    t.integer  "venue_id"
    t.string   "name"
    t.text     "description"
    t.string   "contact_name"
    t.string   "contact_email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "calendar_id"
    t.string   "location"
    t.boolean  "private"
    t.string   "google_event_id"
    t.datetime "deleted_at"
  end

  create_table "devx_extracurricular_teams", force: :cascade do |t|
    t.integer  "extracurricular_id"
    t.integer  "person_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "devx_extracurriculars", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "person_id"
  end

  create_table "devx_faqs", force: :cascade do |t|
    t.string   "question"
    t.text     "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_fields", force: :cascade do |t|
    t.integer  "form_id"
    t.string   "name"
    t.string   "field_type"
    t.integer  "field_size"
    t.boolean  "required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "options"
    t.integer  "position"
  end

  create_table "devx_form_submissions", force: :cascade do |t|
    t.integer  "form_id"
    t.text     "submission_content"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "stripe_id"
    t.boolean  "refunded",           default: false
  end

  create_table "devx_forms", force: :cascade do |t|
    t.integer  "registration_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "name"
    t.string   "slug"
    t.string   "image"
    t.string   "submission_recipients"
    t.integer  "layout_id"
    t.text     "description"
    t.string   "success_message"
    t.boolean  "send_confirmation_email",    default: false
    t.string   "confirmation_email_from"
    t.string   "confirmation_email_subject"
    t.text     "confirmation_email_text"
    t.string   "custom_classes"
  end

  create_table "devx_identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_inventories", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_javascripts", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "active"
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

  create_table "devx_line_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "product_sku_id"
  end

  create_table "devx_linked_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_media", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_menu_pages", force: :cascade do |t|
    t.integer  "menu_id"
    t.integer  "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "position"
    t.integer  "parent_id"
  end

  create_table "devx_menus", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "billing_address_1"
    t.string   "billing_address_2"
    t.string   "billing_address_city"
    t.string   "billing_address_state"
    t.string   "billing_address_zip_code"
    t.string   "shipping_address_1"
    t.string   "shipping_address_2"
    t.string   "shipping_address_city"
    t.string   "shipping_address_state"
    t.string   "shipping_address_zip_code"
    t.string   "stripe_id"
    t.float    "amount"
    t.string   "status"
  end

  create_table "devx_pages", force: :cascade do |t|
    t.integer  "layout_id"
    t.string   "name"
    t.string   "slug"
    t.string   "content"
    t.boolean  "is_home"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "parent"
    t.string   "image"
    t.boolean  "active"
    t.integer  "parent_id"
    t.string   "meta_title"
    t.text     "meta_keywords"
    t.string   "meta_robots"
    t.string   "meta_description"
  end

  add_index "devx_pages", ["parent_id"], name: "index_devx_pages_on_parent_id", using: :btree

  create_table "devx_people", force: :cascade do |t|
    t.string   "prefix"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "suffix"
    t.date     "birthdate"
    t.string   "gender"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "uuid"
    t.string   "position"
    t.boolean  "active"
    t.string   "mobile_number"
    t.string   "photo"
    t.string   "school_id"
    t.datetime "deleted_at"
    t.text     "bio"
    t.float    "current_balance"
  end

  create_table "devx_product_attributes", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "product_attribute"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "devx_product_attributes", ["product_id"], name: "index_devx_product_attributes_on_product_id", using: :btree

  create_table "devx_product_sku_attributes", force: :cascade do |t|
    t.integer  "product_sku_id"
    t.integer  "product_attribute_id"
    t.string   "value"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "devx_product_sku_attributes", ["product_attribute_id"], name: "index_devx_product_sku_attributes_on_product_attribute_id", using: :btree
  add_index "devx_product_sku_attributes", ["product_sku_id"], name: "index_devx_product_sku_attributes_on_product_sku_id", using: :btree

  create_table "devx_product_skus", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "stripe_id"
    t.string   "currency"
    t.float    "price"
    t.boolean  "stockable"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "sku"
    t.float    "price"
    t.float    "weight"
    t.boolean  "taxable"
    t.boolean  "stockable"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
    t.datetime "deleted_at"
    t.string   "stripe_id"
    t.boolean  "active"
    t.string   "slug"
    t.boolean  "shippable"
  end

  create_table "devx_registration_submissions", force: :cascade do |t|
    t.integer  "registration_id"
    t.text     "submission_content"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "devx_registrations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "user_id"
    t.float    "cost"
    t.string   "submission_recipients"
  end

  create_table "devx_roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_schedules", force: :cascade do |t|
    t.integer  "event_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "repeat"
    t.boolean  "all_day"
    t.text     "days",       default: [],              array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "deleted_at"
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
    t.string   "link"
    t.boolean  "active"
  end

  create_table "devx_slideshows", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_sport_teams", force: :cascade do |t|
    t.integer  "sport_id"
    t.integer  "person_id"
    t.integer  "jersey_number"
    t.string   "position"
    t.string   "height"
    t.string   "weight"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "grade"
  end

  create_table "devx_sports", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "person_id"
  end

  create_table "devx_students", force: :cascade do |t|
    t.integer  "person_id"
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

  create_table "devx_ticket_updates", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.text     "comment"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devx_tickets", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "summary"
    t.text     "description"
    t.string   "location"
    t.string   "severity"
    t.string   "status"
    t.string   "file"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "devx_transaction_responses", force: :cascade do |t|
    t.integer  "transaction_id"
    t.text     "message"
    t.text     "code"
    t.string   "token"
    t.string   "state"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "devx_transactions", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "payment_method"
    t.float    "amount"
    t.text     "comments"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "transaction_type"
    t.string   "status"
    t.string   "state"
    t.string   "payment_token"
  end

  create_table "devx_urgent_news", force: :cascade do |t|
    t.string   "title"
    t.text     "message"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "content"
    t.string   "type"
    t.string   "send_to"
    t.string   "recipients"
  end

  create_table "devx_users", force: :cascade do |t|
    t.string   "email",                      default: "", null: false
    t.string   "encrypted_password",         default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",            default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "deleted_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "photo"
    t.integer  "person_id"
    t.string   "stripe_id"
    t.string   "customer_token"
    t.boolean  "receive_text_notifications"
  end

  add_index "devx_users", ["deleted_at"], name: "index_devx_users_on_deleted_at", using: :btree
  add_index "devx_users", ["email"], name: "index_devx_users_on_email", unique: true, using: :btree
  add_index "devx_users", ["person_id"], name: "index_devx_users_on_person_id", using: :btree
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

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end

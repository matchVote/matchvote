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

ActiveRecord::Schema.define(version: 20170614014759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "articles", force: :cascade do |t|
    t.text     "url",                               null: false
    t.text     "title"
    t.string   "authors",              default: [],              array: true
    t.text     "publisher",                         null: false
    t.text     "date_published"
    t.string   "keywords",             default: [],              array: true
    t.text     "summary"
    t.string   "mentioned_officials",  default: [],              array: true
    t.integer  "read_time"
    t.integer  "newsworthiness_count"
    t.text     "top_image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["url"], name: "index_articles_on_url", unique: true, using: :btree

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "article_id"
    t.uuid     "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmarks", ["article_id", "user_id"], name: "index_bookmarks_on_article_id_and_user_id", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "text",                         null: false
    t.uuid     "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "likes",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.text     "emails",           array: true
    t.text     "phone_numbers",    array: true
    t.text     "contact_form_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "website_url"
    t.uuid     "contactable_id"
    t.string   "contactable_type"
    t.hstore   "external_ids"
  end

  add_index "contacts", ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable_type_and_contactable_id", using: :btree

  create_table "inference_opinions", force: :cascade do |t|
    t.boolean  "agrees"
    t.integer  "stance_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inference_opinions", ["stance_id"], name: "index_inference_opinions_on_stance_id", using: :btree
  add_index "inference_opinions", ["user_id"], name: "index_inference_opinions_on_user_id", using: :btree

  create_table "issue_categories", force: :cascade do |t|
    t.text     "name",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "keywords",   default: [],              array: true
  end

  add_index "issue_categories", ["name"], name: "index_issue_categories_on_name", unique: true, using: :btree

  create_table "postal_addresses", force: :cascade do |t|
    t.text     "city"
    t.text     "state"
    t.text     "zip"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "line1"
    t.text     "line2"
  end

  add_index "postal_addresses", ["contact_id"], name: "index_postal_addresses_on_contact_id", using: :btree

  create_table "representatives", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text    "bioguide_id"
    t.text    "title"
    t.text    "first_name",                               null: false
    t.text    "last_name",                                null: false
    t.text    "middle_name"
    t.text    "suffix"
    t.text    "official_full_name"
    t.text    "nickname"
    t.text    "birthday"
    t.text    "gender"
    t.text    "orientation"
    t.text    "government_role"
    t.text    "state"
    t.text    "state_rank"
    t.text    "district"
    t.text    "party"
    t.text    "branch"
    t.text    "religion"
    t.text    "status"
    t.boolean "verified"
    t.text    "profile_image_url"
    t.text    "slug",                                     null: false
    t.text    "biography"
    t.integer "user_id"
    t.integer "name_recognition",   limit: 8, default: 0
    t.text    "seniority_date"
    t.text    "office"
  end

  add_index "representatives", ["first_name", "last_name"], name: "index_representatives_on_first_name_and_last_name", using: :btree
  add_index "representatives", ["first_name"], name: "index_representatives_on_first_name", using: :btree
  add_index "representatives", ["last_name"], name: "index_representatives_on_last_name", using: :btree
  add_index "representatives", ["slug"], name: "index_representatives_on_slug", unique: true, using: :btree
  add_index "representatives", ["user_id"], name: "index_representatives_on_user_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "var",         null: false
    t.text     "value"
    t.integer  "target_id",   null: false
    t.string   "target_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true, using: :btree

  create_table "stance_events", force: :cascade do |t|
    t.integer  "action",            default: 0, null: false
    t.integer  "agreeance_value"
    t.integer  "importance_value"
    t.integer  "stance_id"
    t.integer  "statement_id"
    t.integer  "issue_category_id"
    t.uuid     "opinionable_id"
    t.string   "opinionable_type"
    t.uuid     "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stance_events", ["created_by"], name: "index_stance_events_on_created_by", using: :btree
  add_index "stance_events", ["issue_category_id"], name: "index_stance_events_on_issue_category_id", using: :btree
  add_index "stance_events", ["opinionable_type", "opinionable_id"], name: "index_stance_events_on_opinionable_type_and_opinionable_id", using: :btree
  add_index "stance_events", ["stance_id"], name: "index_stance_events_on_stance_id", using: :btree
  add_index "stance_events", ["statement_id"], name: "index_stance_events_on_statement_id", using: :btree

  create_table "stance_quotes", force: :cascade do |t|
    t.text     "quote"
    t.text     "quote_url"
    t.integer  "stance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "quote_timestamp"
  end

  add_index "stance_quotes", ["stance_id"], name: "index_stance_quotes_on_stance_id", using: :btree

  create_table "stances", force: :cascade do |t|
    t.integer  "agreeance_value"
    t.integer  "importance_value"
    t.boolean  "skipped"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "opinionable_id"
    t.string   "opinionable_type"
    t.text     "inferred_by"
    t.boolean  "verified"
    t.integer  "statement_id"
  end

  add_index "stances", ["opinionable_id", "statement_id"], name: "index_stances_on_opinionable_id_and_statement_id", unique: true, using: :btree
  add_index "stances", ["opinionable_id"], name: "index_stances_on_opinionable_id", using: :btree
  add_index "stances", ["opinionable_type", "opinionable_id"], name: "index_stances_on_opinionable_type_and_opinionable_id", using: :btree
  add_index "stances", ["statement_id"], name: "index_stances_on_statement_id", using: :btree

  create_table "statements", force: :cascade do |t|
    t.text     "text",              null: false
    t.integer  "issue_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "lean"
    t.integer  "lean_weight"
  end

  add_index "statements", ["issue_category_id"], name: "index_statements_on_issue_category_id", using: :btree
  add_index "statements", ["text"], name: "statements_text_key", unique: true, using: :btree

  create_table "user_article_changes", force: :cascade do |t|
    t.integer  "article_id"
    t.uuid     "user_id"
    t.text     "change_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_article_changes", ["article_id", "user_id"], name: "index_user_article_changes_on_article_id_and_user_id", unique: true, using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "admin"
    t.text     "profile_type"
    t.uuid     "profile_id"
    t.boolean  "rep_admin",              default: false
    t.text     "rep_slug"
    t.hstore   "personal_info"
    t.string   "profile_pic"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "comments", "users"
end

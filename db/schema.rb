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

ActiveRecord::Schema.define(version: 20150422101754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "contacts", force: :cascade do |t|
    t.text     "emails",            default: [], array: true
    t.text     "phone_numbers",     default: [], array: true
    t.text     "contact_form_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "website_url"
    t.uuid     "representative_id"
  end

  add_index "contacts", ["representative_id"], name: "index_contacts_on_representative_id", unique: true, using: :btree

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
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "keywords",   default: [], array: true
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

  create_table "profiles", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "type"
    t.text     "title"
    t.text     "first_name",           null: false
    t.text     "last_name",            null: false
    t.text     "middle_names"
    t.text     "suffix"
    t.text     "birthday"
    t.string   "gender"
    t.text     "government_role"
    t.string   "state"
    t.text     "district"
    t.text     "party"
    t.text     "biography"
    t.text     "religion"
    t.hstore   "external_credentials"
    t.integer  "user_id"
    t.text     "profile_image_url"
    t.text     "status"
    t.boolean  "verified"
    t.text     "state_rank"
    t.string   "branch"
    t.text     "orientation"
    t.text     "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["first_name", "last_name"], name: "index_profiles_on_first_name_and_last_name", unique: true, using: :btree
  add_index "profiles", ["first_name"], name: "index_profiles_on_first_name", using: :btree
  add_index "profiles", ["last_name"], name: "index_profiles_on_last_name", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "representatives", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text    "bioguide_id"
    t.text    "title"
    t.text    "first_name",                                 null: false
    t.text    "last_name",                                  null: false
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
    t.text    "slug",                                       null: false
    t.text    "biography"
    t.hstore  "external_credentials"
    t.integer "user_id"
    t.integer "name_recognition",     limit: 8, default: 0
    t.text    "seniority_date"
    t.text    "office"
  end

  add_index "representatives", ["first_name", "last_name"], name: "index_representatives_on_first_name_and_last_name", using: :btree
  add_index "representatives", ["first_name"], name: "index_representatives_on_first_name", using: :btree
  add_index "representatives", ["last_name"], name: "index_representatives_on_last_name", using: :btree
  add_index "representatives", ["slug"], name: "index_representatives_on_slug", unique: true, using: :btree
  add_index "representatives", ["user_id"], name: "index_representatives_on_user_id", using: :btree

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
  end

  add_index "stances", ["opinionable_type", "opinionable_id"], name: "index_stances_on_opinionable_type_and_opinionable_id", using: :btree

  create_table "statements", force: :cascade do |t|
    t.string   "text"
    t.integer  "issue_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statements", ["issue_category_id"], name: "index_statements_on_issue_category_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "profile_id"
    t.boolean  "admin"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["profile_id"], name: "index_users_on_profile_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end

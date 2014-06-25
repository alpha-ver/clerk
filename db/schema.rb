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

ActiveRecord::Schema.define(version: 20140610120336) do

  create_table "categories", force: true do |t|
    t.string   "name",       null: false
    t.integer  "parent_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name"

  create_table "documents", force: true do |t|
    t.string   "name",        null: false
    t.string   "path",        null: false
    t.string   "extension",   null: false
    t.integer  "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["path"], name: "index_documents_on_path", unique: true

  create_table "fields", force: true do |t|
    t.string   "name",       null: false
    t.string   "code",       null: false
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fields", ["code"], name: "index_fields_on_code", unique: true

  create_table "template_fields", force: true do |t|
    t.string   "val"
    t.integer  "template_id", null: false
    t.integer  "field_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "template_fields", ["template_id", "field_id"], name: "index_template_fields_on_template_id_and_field_id", unique: true

  create_table "templates", force: true do |t|
    t.string   "name",       null: false
    t.text     "about"
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "templates", ["user_id"], name: "index_templates_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

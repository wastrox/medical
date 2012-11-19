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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121107121433) do

  create_table "accounts", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "salt"
    t.string   "token"
    t.string   "account_type"
    t.boolean  "active",          :default => false
    t.datetime "activated_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "applicants", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "surename"
    t.date     "date"
    t.string   "city"
    t.integer  "phone"
    t.text     "about_me"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "educations", :force => true do |t|
    t.integer  "applicant_id"
    t.string   "college"
    t.boolean  "student"
    t.string   "profession"
    t.string   "diploma"
    t.string   "faculty"
    t.date     "till"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "educations", ["applicant_id"], :name => "index_educations_on_applicant_id"

  create_table "experiences", :force => true do |t|
    t.integer  "applicant_id"
    t.string   "position"
    t.string   "company"
    t.text     "achievements"
    t.date     "from"
    t.date     "till"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "experiences", ["applicant_id"], :name => "index_experiences_on_applicant_id"

  create_table "languages", :force => true do |t|
    t.integer  "applicant_id"
    t.string   "language"
    t.integer  "skill"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "languages", ["applicant_id"], :name => "index_languages_on_applicant_id"

  create_table "pc_skills", :force => true do |t|
    t.integer  "applicant_id"
    t.string   "name"
    t.integer  "skill"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "pc_skills", ["applicant_id"], :name => "index_pc_skills_on_applicant_id"

end

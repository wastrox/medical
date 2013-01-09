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

ActiveRecord::Schema.define(:version => 20130108133724) do

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

  create_table "educations", :force => true do |t|
    t.integer  "resume_id"
    t.string   "college"
    t.boolean  "student"
    t.string   "profession"
    t.string   "diploma"
    t.string   "faculty"
    t.date     "till"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "educations", ["resume_id"], :name => "index_educations_on_resume_id"

  create_table "experiences", :force => true do |t|
    t.integer  "resume_id"
    t.string   "position"
    t.string   "company"
    t.text     "achievements"
    t.date     "from"
    t.date     "till"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "experiences", ["resume_id"], :name => "index_experiences_on_resume_id"

  create_table "profiles", :force => true do |t|
    t.integer  "resume_id"
    t.integer  "applicant_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "surename"
    t.date     "date"
    t.integer  "phone"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "profiles", ["resume_id"], :name => "index_profiles_on_resume_id"

  create_table "resumes", :force => true do |t|
    t.integer  "applicant_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "position"
    t.string   "salary"
    t.string   "city"
    t.string   "additional_info"
  end

  add_index "resumes", ["applicant_id"], :name => "index_resumes_on_applicant_id"

end
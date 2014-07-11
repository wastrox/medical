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

ActiveRecord::Schema.define(version: 20140709085429) do

  create_table "accounts", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "salt"
    t.string   "token"
    t.string   "account_type"
    t.boolean  "active",                 default: false
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "session_count",          default: 0
    t.datetime "session_last_time"
    t.boolean  "delta",                  default: true,  null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "accounts", ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true, using: :btree
  add_index "accounts", ["delta"], name: "index_accounts_on_delta", using: :btree
  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree

  create_table "articles", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.text     "body"
    t.datetime "published_at"
    t.string   "state"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scope_id"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.integer  "morpher_id"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "morpher_id"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "site"
    t.text     "description"
    t.integer  "employer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "state"
    t.boolean  "delta",             default: true, null: false
    t.integer  "scope_id"
  end

  add_index "companies", ["delta"], name: "index_companies_on_delta", using: :btree
  add_index "companies", ["employer_id"], name: "index_companies_on_employer_id", using: :btree

  create_table "company_contacts", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_contacts", ["company_id"], name: "index_company_contacts_on_company_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
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

  create_table "educations", force: true do |t|
    t.integer  "resume_id"
    t.string   "college"
    t.boolean  "student"
    t.string   "profession"
    t.string   "diploma"
    t.string   "faculty"
    t.integer  "year_till"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "educations", ["resume_id"], name: "index_educations_on_resume_id", using: :btree

  create_table "experiences", force: true do |t|
    t.integer  "resume_id"
    t.string   "position"
    t.string   "company"
    t.text     "achievements"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "month_from"
    t.integer  "year_from"
    t.string   "month_till"
    t.integer  "year_till"
    t.boolean  "current_workplace"
  end

  add_index "experiences", ["resume_id"], name: "index_experiences_on_resume_id", using: :btree

  create_table "hot_vacancies", force: true do |t|
    t.integer  "vacancy_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hot_vacancies", ["vacancy_id"], name: "index_hot_vacancies_on_vacancy_id", using: :btree

  create_table "morphers", force: true do |t|
    t.text     "case"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.integer  "resume_id"
    t.integer  "applicant_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "surename"
    t.date     "date"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "profiles", ["resume_id"], name: "index_profiles_on_resume_id", using: :btree

  create_table "resume_responds", force: true do |t|
    t.integer  "resume_id"
    t.integer  "employer_id"
    t.date     "respond_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resume_responds", ["employer_id"], name: "index_resume_responds_on_employer_id", using: :btree
  add_index "resume_responds", ["resume_id"], name: "index_resume_responds_on_resume_id", using: :btree

  create_table "resumes", force: true do |t|
    t.integer  "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "position"
    t.integer  "salary",          default: 0
    t.string   "city"
    t.text     "additional_info"
    t.string   "state"
    t.boolean  "delta",           default: true, null: false
  end

  add_index "resumes", ["applicant_id"], name: "index_resumes_on_applicant_id", using: :btree
  add_index "resumes", ["delta"], name: "index_resumes_on_delta", using: :btree

  create_table "scopes", force: true do |t|
    t.string   "title"
    t.text     "description",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.integer  "morpher_id"
  end

  create_table "tasks", force: true do |t|
    t.integer  "index"
    t.text     "description"
    t.boolean  "complete",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vacancies", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "city"
    t.integer  "salary",             default: 0
    t.string   "experiences"
    t.string   "timetable"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "timetable_other"
    t.integer  "company_contact_id"
    t.boolean  "delta",              default: true,                  null: false
    t.string   "state"
    t.integer  "category_id"
    t.datetime "publicated_at",      default: '2014-07-11 08:38:57'
  end

  add_index "vacancies", ["company_id"], name: "index_vacancies_on_company_id", using: :btree
  add_index "vacancies", ["delta"], name: "index_vacancies_on_delta", using: :btree

  create_table "vacancy_responds", force: true do |t|
    t.integer  "vacancy_id"
    t.integer  "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "respond_date"
    t.string   "vacancy_name"
  end

  add_index "vacancy_responds", ["applicant_id"], name: "index_vacancy_responds_on_applicant_id", using: :btree
  add_index "vacancy_responds", ["vacancy_id"], name: "index_vacancy_responds_on_vacancy_id", using: :btree

end

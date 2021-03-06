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

ActiveRecord::Schema.define(:version => 20140516090542) do

  create_table "accounts", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "salt"
    t.string   "token"
    t.string   "account_type"
    t.boolean  "active",            :default => false
    t.datetime "activated_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "session_count",     :default => 0
    t.datetime "session_last_time"
    t.boolean  "delta",             :default => true,  :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.text     "body"
    t.datetime "published_at"
    t.string   "state"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "scope_id"
    t.text     "description",        :null => false
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.integer  "morpher_id"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "morpher_id"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "site"
    t.text     "description"
    t.integer  "employer_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "state"
    t.boolean  "delta",             :default => true, :null => false
    t.integer  "scope_id"
  end

  add_index "companies", ["employer_id"], :name => "index_companies_on_employer_id"

  create_table "company_contacts", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "company_contacts", ["company_id"], :name => "index_company_contacts_on_company_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "educations", :force => true do |t|
    t.integer  "resume_id"
    t.string   "college"
    t.boolean  "student"
    t.string   "profession"
    t.string   "diploma"
    t.string   "faculty"
    t.integer  "year_till"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "educations", ["resume_id"], :name => "index_educations_on_resume_id"

  create_table "experiences", :force => true do |t|
    t.integer  "resume_id"
    t.string   "position"
    t.string   "company"
    t.text     "achievements"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "month_from"
    t.integer  "year_from"
    t.string   "month_till"
    t.integer  "year_till"
    t.boolean  "current_workplace"
  end

  add_index "experiences", ["resume_id"], :name => "index_experiences_on_resume_id"

  create_table "hot_vacancies", :force => true do |t|
    t.integer  "vacancy_id"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "hot_vacancies", ["vacancy_id"], :name => "index_hot_vacancies_on_vacancy_id"

  create_table "morphers", :force => true do |t|
    t.text     "case"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "resume_id"
    t.integer  "applicant_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "surename"
    t.date     "date"
    t.string   "phone"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "profiles", ["resume_id"], :name => "index_profiles_on_resume_id"

  create_table "resume_responds", :force => true do |t|
    t.integer  "resume_id"
    t.integer  "employer_id"
    t.date     "respond_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "resume_responds", ["employer_id"], :name => "index_resume_responds_on_employer_id"
  add_index "resume_responds", ["resume_id"], :name => "index_resume_responds_on_resume_id"

  create_table "resumes", :force => true do |t|
    t.integer  "applicant_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "position"
    t.integer  "salary",          :default => 0
    t.string   "city"
    t.text     "additional_info"
    t.string   "state"
    t.boolean  "delta",           :default => true, :null => false
  end

  add_index "resumes", ["applicant_id"], :name => "index_resumes_on_applicant_id"

  create_table "scopes", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "description",        :null => false
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.integer  "morpher_id"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "index"
    t.text     "description"
    t.boolean  "complete",    :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "vacancies", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "city"
    t.integer  "salary",             :default => 0
    t.string   "experiences"
    t.string   "timetable"
    t.text     "description"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "timetable_other"
    t.integer  "company_contact_id"
    t.boolean  "delta",              :default => true,                  :null => false
    t.string   "state"
    t.integer  "category_id"
    t.datetime "publicated_at",      :default => '2013-09-11 10:38:24'
  end

  add_index "vacancies", ["company_id"], :name => "index_vacancies_on_company_id"

  create_table "vacancy_responds", :force => true do |t|
    t.integer  "vacancy_id"
    t.integer  "applicant_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.date     "respond_date"
    t.string   "vacancy_name"
  end

  add_index "vacancy_responds", ["applicant_id"], :name => "index_vacancy_responds_on_applicant_id"
  add_index "vacancy_responds", ["vacancy_id"], :name => "index_vacancy_responds_on_vacancy_id"

end

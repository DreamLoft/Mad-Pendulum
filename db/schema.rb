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

ActiveRecord::Schema.define(version: 20170811080800) do

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
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "projections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.date     "joindate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_projections_on_project_id"
    t.index ["user_id"], name: "index_projections_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "jobid"
    t.string   "projectname"
    t.string   "clientname"
    t.date     "startdate"
    t.string   "projectstatus"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "sbu"
    t.integer  "project_lead"
    t.integer  "project_manager"
    t.string   "close_remarks"
    t.date     "end_date"
    t.boolean  "is_active",       default: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "taskname"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "task_category"
  end

  create_table "timesheets", force: :cascade do |t|
    t.integer "project_id"
    t.integer "task_id"
    t.date    "Tdate"
    t.float   "timespent"
    t.integer "feeling"
    t.integer "user_id"
    t.float   "totaltasktime"
    t.index ["project_id"], name: "index_timesheets_on_project_id"
    t.index ["task_id"], name: "index_timesheets_on_task_id"
    t.index ["user_id"], name: "index_timesheets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "designation"
    t.string   "mobileno"
    t.float    "version"
    t.boolean  "isadmin",                default: false
    t.boolean  "ismanagement",           default: false
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,       null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "employee_id"
    t.boolean  "is_project_manager",     default: false
    t.boolean  "is_project_lead",        default: false
    t.float    "weight"
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.text     "tokens"
    t.boolean  "approved",               default: false,   null: false
    t.string   "Sbu"
    t.boolean  "onLeave"
    t.index ["Sbu"], name: "index_users_on_Sbu"
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end

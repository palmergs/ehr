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

ActiveRecord::Schema.define(version: 20130524193745) do

  create_table "allergies", force: true do |t|
    t.integer  "user_id"
    t.integer  "patient_id"
    t.string   "medication_or_food"
    t.string   "reaction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "appointment_id"
  end

  add_index "allergies", ["appointment_id"], name: "index_allergies_on_appointment_id", using: :btree

  create_table "appointments", force: true do |t|
    t.integer  "user_id"
    t.integer  "patient_id"
    t.string   "appointment_type"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "canceled_at"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_doctor_relations", force: true do |t|
    t.integer  "user_id"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: true do |t|
    t.string   "ident"
    t.string   "fname"
    t.string   "lname"
    t.string   "mname"
    t.date     "dob"
    t.string   "status"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "occupation"
    t.string   "marital_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "prescriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "patient_id"
    t.string   "medication_status"
    t.string   "prescription"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "appointment_id"
  end

  add_index "prescriptions", ["appointment_id"], name: "index_prescriptions_on_appointment_id", using: :btree

  create_table "progress_notes", force: true do |t|
    t.integer  "user_id"
    t.integer  "patient_id"
    t.integer  "appointment_id"
    t.string   "interim_history"
    t.string   "medications_side_effects"
    t.string   "impression_diagnosis"
    t.string   "plan"
    t.string   "therapy_type"
    t.string   "therapy_mins"
    t.boolean  "majority_counceling_coord"
    t.string   "appearance"
    t.string   "behavior"
    t.string   "speech"
    t.string   "though_process"
    t.string   "mood_affect"
    t.string   "vital_sense"
    t.string   "sihi"
    t.string   "hallucinations"
    t.string   "delusions"
    t.string   "phobias_obsessions"
    t.string   "cognitive_state"
    t.string   "insight_judgement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fname",                  default: "First"
    t.string   "lname",                  default: "Last"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["lname"], name: "index_users_on_lname", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

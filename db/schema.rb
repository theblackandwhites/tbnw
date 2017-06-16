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

ActiveRecord::Schema.define(version: 20170614111824) do

  create_table "answers", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.string   "color_hex"
    t.string   "icon_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charges", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount"
    t.string   "credit_card_last_4"
    t.string   "credit_card_exp_month"
    t.string   "credit_card_exp_year"
    t.string   "credit_card_type"
    t.string   "stripe_charge_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["user_id"], name: "index_charges_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "hack_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hack_id"], name: "index_comments_on_hack_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "hacks", force: :cascade do |t|
    t.string   "video_embed_code"
    t.boolean  "members_only"
    t.string   "title"
    t.text     "description"
    t.integer  "category_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "thumb"
    t.text     "links"
    t.index ["category_id"], name: "index_hacks_on_category_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "workshop_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
    t.index ["workshop_id"], name: "index_messages_on_workshop_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.index ["category_id"], name: "index_questions_on_category_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "replies", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "hack_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_replies_on_comment_id"
    t.index ["hack_id"], name: "index_replies_on_hack_id"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "reply_answers", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["answer_id"], name: "index_reply_answers_on_answer_id"
    t.index ["question_id"], name: "index_reply_answers_on_question_id"
    t.index ["user_id"], name: "index_reply_answers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.text     "address"
    t.string   "postcode"
    t.string   "company_name"
    t.string   "stripe_id"
    t.string   "stripe_subscription_id"
    t.string   "credit_card_last_4"
    t.string   "credit_card_exp_month"
    t.string   "credit_card_exp_year"
    t.string   "credit_card_type"
    t.boolean  "suspended"
    t.boolean  "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workshops", force: :cascade do |t|
    t.string   "start_time"
    t.string   "finish_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.date     "start_date"
    t.decimal  "start_hour"
    t.decimal  "start_minute"
    t.decimal  "start_second"
    t.boolean  "status_closed"
  end

end

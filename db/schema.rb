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

ActiveRecord::Schema.define(version: 2020_02_07_053158) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "phone_number"
    t.string "postal_code"
    t.integer "prefecture"
    t.string "city"
    t.string "house_number"
    t.string "building_name"
    t.bigint "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brand_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brandname_brandgroups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "brand_name_id", null: false
    t.bigint "brand_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_group_id"], name: "fk_rails_d42e956917"
    t.index ["brand_name_id"], name: "fk_rails_4af7cf33db"
  end

  create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "customer_token", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "fk_rails_8ef7749967"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_brandgroups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "brand_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_group_id"], name: "fk_rails_9ebe964d1e"
    t.index ["category_id"], name: "fk_rails_9506136a79"
  end

  create_table "category_sizegroups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "size_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "fk_rails_2c768a8843"
    t.index ["size_group_id"], name: "fk_rails_3697fc4098"
  end

  create_table "comment_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "comment", null: false
    t.bigint "item_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "fk_rails_2f0118f334"
    t.index ["user_id"], name: "fk_rails_0e7ab29a98"
  end

  create_table "dealing_chat_messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "message", null: false
    t.bigint "dealing_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dealing_id"], name: "fk_rails_76fdd5dd9a"
    t.index ["user_id"], name: "fk_rails_1602a208ba"
  end

  create_table "dealings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "phase", default: 0
    t.datetime "buyer_datetime"
    t.datetime "seller_datetime"
    t.bigint "item_id"
    t.bigint "buyer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "fk_rails_73c75bea01"
    t.index ["item_id"], name: "fk_rails_7bbca02b1e"
  end

  create_table "item_brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "brand_name_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_name_id"], name: "fk_rails_e1d5aae2e0"
    t.index ["item_id"], name: "fk_rails_161711efd3"
  end

  create_table "item_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "image", null: false
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "fk_rails_18c95d5ce3"
  end

  create_table "item_sizes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "size_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "fk_rails_27bab57bd2"
    t.index ["size_id"], name: "fk_rails_461812b7dd"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.text "detail", null: false
    t.integer "condition", null: false
    t.integer "delivery_fee_payer", null: false
    t.integer "delivery_method", null: false
    t.integer "delivery_agency", null: false
    t.integer "delivery_days", null: false
    t.integer "deal", default: 0
    t.bigint "category_id", null: false
    t.bigint "seller_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "fk_rails_89fb86dc8b"
    t.index ["seller_id"], name: "fk_rails_62a5ac8242"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "fk_rails_00045f60f7"
    t.index ["user_id"], name: "fk_rails_1e09b5dabf"
  end

  create_table "size_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sizes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "group_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sns_credentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "fk_rails_c5d66654bc"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "nickname", null: false
    t.string "avatar"
    t.text "introduction", null: false
    t.string "first_name", null: false
    t.string "first_name_reading", null: false
    t.string "last_name", null: false
    t.string "last_name_reading", null: false
    t.date "birthday", null: false
    t.integer "earnings", default: 0
    t.integer "points", default: 0
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "values", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "dealing_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dealing_id"], name: "fk_rails_204225f64b"
    t.index ["user_id"], name: "fk_rails_690f376fee"
  end

  add_foreign_key "brandname_brandgroups", "brand_groups"
  add_foreign_key "brandname_brandgroups", "brand_names"
  add_foreign_key "cards", "users"
  add_foreign_key "category_brandgroups", "brand_groups"
  add_foreign_key "category_brandgroups", "categories"
  add_foreign_key "category_sizegroups", "categories"
  add_foreign_key "category_sizegroups", "size_groups"
  add_foreign_key "comment_items", "items"
  add_foreign_key "comment_items", "users"
  add_foreign_key "dealing_chat_messages", "dealings"
  add_foreign_key "dealing_chat_messages", "users"
  add_foreign_key "dealings", "items"
  add_foreign_key "dealings", "users", column: "buyer_id"
  add_foreign_key "item_brands", "brand_names"
  add_foreign_key "item_brands", "items"
  add_foreign_key "item_images", "items"
  add_foreign_key "item_sizes", "items"
  add_foreign_key "item_sizes", "sizes"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "users", column: "seller_id"
  add_foreign_key "likes", "items"
  add_foreign_key "likes", "users"
  add_foreign_key "sns_credentials", "users"
  add_foreign_key "values", "dealings"
  add_foreign_key "values", "users"
end

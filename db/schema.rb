# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2001) do
  create_table "check_receives", charset: "utf8mb4", comment: "サンプル受信API", force: :cascade do |t|
    t.string "amount", limit: 15, comment: "取引金額"
    t.string "seq_no", limit: 6, comment: "取引通番"
    t.string "settlement_day", limit: 8, comment: "勘定日付"
    t.string "tran_time", limit: 14, comment: "トランザクション日時"
    t.string "atm_id", limit: 6, comment: "ATM番号"
    t.string "sec_inf", comment: "詳細情報"
    t.integer "status", default: 0, comment: "ステータス"
    t.integer "create_id", comment: "作成者"
    t.integer "update_id", comment: "更新者"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", charset: "utf8mb4", comment: "顧客", force: :cascade do |t|
    t.string "name", limit: 20, null: false, comment: "顧客名"
    t.integer "create_id", comment: "作成者"
    t.integer "update_id", comment: "更新者"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", charset: "utf8mb4", comment: "メニュー", force: :cascade do |t|
    t.integer "parent_id", comment: "親ID"
    t.integer "child_id", comment: "子ID"
    t.string "logical_name", limit: 100, comment: "論理名"
    t.string "physical_name", limit: 100, comment: "物理名"
    t.string "url", limit: 100, comment: "URL"
    t.integer "display_order", comment: "表示順"
    t.boolean "is_show", default: true, null: false, comment: "メニュー表示"
    t.integer "create_id", comment: "作成者"
    t.integer "update_id", comment: "更新者"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_menus", charset: "utf8mb4", comment: "ロール～メニューリンク", force: :cascade do |t|
    t.bigint "role_id", comment: "ロール"
    t.bigint "menu_id", comment: "メニュー"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["menu_id"], name: "index_role_menus_on_menu_id"
    t.index ["role_id"], name: "index_role_menus_on_role_id"
  end

  create_table "roles", charset: "utf8mb4", comment: "ロール", force: :cascade do |t|
    t.string "name", limit: 20, null: false, comment: "名前"
    t.text "explanation", comment: "説明"
    t.integer "create_id", comment: "作成者"
    t.integer "update_id", comment: "更新者"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", charset: "utf8mb4", comment: "ユーザー", force: :cascade do |t|
    t.string "name", limit: 20, null: false, comment: "名前"
    t.integer "client_id", null: false, comment: "顧客ID"
    t.integer "role_id", null: false, comment: "ロールID"
    t.boolean "is_deposit_prohibited", default: false, comment: "入金禁止"
    t.string "locale", limit: 2, comment: "ロケール"
    t.integer "create_id", comment: "作成者"
    t.integer "update_id", comment: "更新者"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["client_id"], name: "index_users_on_client_id"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "role_menus", "menus"
  add_foreign_key "role_menus", "roles"
end

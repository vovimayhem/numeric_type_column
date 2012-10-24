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

ActiveRecord::Schema.define(:version => 20121024034824) do

  create_table "unsigned_columns_tests", :force => true do |t|
    t.integer  "integer_unsigned_column",       :limit => 2,  :unsigned => true
    t.integer  "integer_signed_column",         :limit => 2
    t.string   "string_column",                 :limit => 24
    t.decimal  "decimal_unsigned_column",                     :unsigned => true, :precision => 4, :scale => 2
    t.float    "unsigned_float_column",                       :unsigned => true
    t.boolean  "boolean_unsigned_column",                     :unsigned => true
    t.integer  "references_unsigned_column_id",               :unsigned => true
    t.datetime "created_at",                                                                                   :null => false
    t.datetime "updated_at",                                                                                   :null => false
  end

  add_index "unsigned_columns_tests", ["references_unsigned_column_id"], :name => "FK_unsigned_references_column_test"

end

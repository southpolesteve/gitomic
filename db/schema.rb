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

ActiveRecord::Schema.define(:version => 20120913050217) do

  create_table "issue_labels", :force => true do |t|
    t.integer  "label_id"
    t.integer  "issue_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "issue_labels", ["issue_id"], :name => "index_issue_labels_on_issue_id"
  add_index "issue_labels", ["label_id"], :name => "index_issue_labels_on_label_id"

  create_table "issues", :force => true do |t|
    t.string   "state"
    t.datetime "closed_at"
    t.string   "milestone"
    t.integer  "number"
    t.text     "body"
    t.string   "title"
    t.datetime "github_created_at"
    t.datetime "github_updated_at"
    t.integer  "github_id"
    t.integer  "project_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "user_id"
    t.string   "github_state"
    t.integer  "priority"
    t.integer  "list_id"
    t.string   "github_url"
    t.integer  "assignee_id"
  end

  add_index "issues", ["list_id"], :name => "index_issues_on_list_id"
  add_index "issues", ["project_id"], :name => "index_issues_on_project_id"
  add_index "issues", ["user_id"], :name => "index_issues_on_user_id"

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "list"
  end

  add_index "labels", ["project_id"], :name => "index_labels_on_project_id"

  create_table "lists", :force => true do |t|
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "lists", ["project_id"], :name => "index_lists_on_project_id"

  create_table "project_memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "project_memberships", ["project_id"], :name => "index_project_memberships_on_project_id"
  add_index "project_memberships", ["user_id"], :name => "index_project_memberships_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "owner"
    t.string   "name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "user_id"
    t.datetime "labels_imported_at"
    t.datetime "issues_imported_at"
    t.boolean  "org"
  end

  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "avatar"
    t.string   "github_token"
    t.string   "github_login"
  end

end

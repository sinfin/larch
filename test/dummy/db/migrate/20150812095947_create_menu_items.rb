class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table "menu_items", force: :cascade do |t|
      t.string   :title
      t.integer  :content_id
      t.string   :content_type
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :ancestry
      t.integer  :ancestry_depth, default: 0
      t.integer  :position
      t.boolean  :fixed,          default: false
      t.string   :system_name
    end
  end
end

class PagesTags < ActiveRecord::Migration
  def up
    create_table :tag_mappings do |t|
      t.integer :page_id
      t.integer :tag_id
      t.integer :created_by

      t.timestamps
    end
  end

  def down
    drop_table :tag_mappings
  end
end

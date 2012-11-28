class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.text :body
      t.integer :page_id
      t.integer :created_by

      t.timestamps
    end
  end
end

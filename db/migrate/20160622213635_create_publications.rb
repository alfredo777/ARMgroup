class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.text :content
      t.integer :admin_id
      t.string :head_image

      t.timestamps null: false
    end
  end
end

class CreateSharedFiles < ActiveRecord::Migration
  def change
    create_table :shared_files do |t|
      t.string :url
      t.string :name
      t.integer :fileable_id
      t.string :fileable_type
      t.integer :admin_id

      t.timestamps null: false
    end
    add_index :shared_files, :fileable_id
    add_index :shared_files, :fileable_type
  end
end

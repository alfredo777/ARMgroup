class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :content
      t.integer :customer_id
      t.integer :admin_id

      t.timestamps null: false
    end
    add_index :notices, :customer_id
    add_index :notices, :admin_id
  end
end

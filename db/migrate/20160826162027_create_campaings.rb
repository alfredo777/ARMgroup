class CreateCampaings < ActiveRecord::Migration
  def change
    create_table :campaings do |t|
      t.integer :customer_id
      t.integer :admin_id
      t.string :campaing_code
      t.string :campaing_title
      t.boolean :active
      t.boolean :restrict_audio_download

      t.timestamps null: false
    end
    add_index :campaings, :customer_id
    add_index :campaings, :admin_id
    add_index :campaings, :campaing_code
    add_index :campaings, :active
  end
end

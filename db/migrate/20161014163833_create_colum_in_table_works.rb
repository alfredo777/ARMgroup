class CreateColumInTableWorks < ActiveRecord::Migration
  def change
    create_table :colum_in_table_works do |t|
      t.integer :table_work_id
      t.string :register_in_data_base
      t.boolean :priority
      t.string :alias
      t.boolean :stringt
      t.boolean :integert
      t.boolean :booleant

      t.timestamps null: false
    end
     add_index :colum_in_table_works, :table_work_id
  end
end

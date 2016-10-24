class CreateTableWorks < ActiveRecord::Migration
  def change
    create_table :table_works do |t|
      t.integer :work_schema_id
      t.string :register_in_data_base
      t.boolean :priority
      t.string :alias

      t.timestamps null: false
    end
     add_index :table_works, :work_schema_id
  end
end
